Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159D3C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 08:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD13E2075E
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 08:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GrbFNL0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD13E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F8D76EB15;
	Thu, 17 Sep 2020 08:21:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980546E997
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 08:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbp8mUE+FhnVAVP6BU+YmqUNXoJAwKsuGVmVW6lXrn202EUBB21FxWU/q3t97ThA9ipqAD+xOh6O5RYh90xq6vkaxo+P8nMuyou/gPJPHZnq4PQvgwNEjeF1mBpvmvIO2OMcJlD2+LQFFk5d8fX5ukFwT6lQHaoPAW/5trqs0L8AGThGHDneCdeUaBOJE9i11z70p/Zv8bMPoazscIPodWqQRv5QQ2otqYEcYqzFvwYaDLO5UupHdWE7hIU3DquZcskMyKfgGB0gLLpHG4rrIEhMBrio6i73lKNrt3GgAJU6ixkGtqiisfDBHyuUcXtkk33XfA/EY554b4ZnlNf6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vXDTn1il1pUZjaVVIKCZM0TeNdyngZpDfRraGeyZyE=;
 b=MmtvvvrCBNQmlB7RbBmv04LaquipM+y+c2p607t5qSWJSU9oexYOnQkDSo7jAP9WhChvoif2LSe+GAvxE6p71C4EqyOsXRuuAiw4920HFkLNF8GinVfK8QNG0u3+dxX6NKYSctPcUJS9fnhm5xaIXFKcEJfex3knmhU0pl/iR5xXhs4Njb7HMSv5z98RWYIOnBg/XpEtxkzu8D5Ewk5Z8RB/t6nHTg2IL/NFUN5gmU3R9DYmrNUtgPJQTNKRBzY4gL/ah8QtqdeFknflkZkCuZneY+6euJgg23OyQBXth95fVnhhwmwfC6LtbOkfkmyUNJbHo4h7iubajKJpQKk0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vXDTn1il1pUZjaVVIKCZM0TeNdyngZpDfRraGeyZyE=;
 b=GrbFNL0wj1EiJe/PArIebIA6TybxAIkuta/MSlYftvhUBwee8o4+P8FUMreFfE+++4sWTM2jlDTuP+z7JQ2mFiXj9HlL7ae0Vz1kw9jaVWeQjZgio5OHthOrA6HFjKVBxQcqMvYixGKKFzeEU89XhpmM0bfWN6PiRPLTPrTs7Xk=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Thu, 17 Sep
 2020 08:21:25 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e9ab:dad0:9d7a:a0e3]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e9ab:dad0:9d7a:a0e3%3]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 08:21:25 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Thread-Topic: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Thread-Index: AQHWjMru86XQ9OsFvEGDSIuX3PGp6KlsfPsA
Date: Thu, 17 Sep 2020 08:21:24 +0000
Message-ID: <CY4PR12MB12875D75473E9D52A07A745CF13E0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200917081035.1024221-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20200917081035.1024221-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-17T08:20:13Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2448d157-4791-45b2-8db7-00003495e8b7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-17T08:21:22Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 28b2809e-a4cb-4eb8-b842-0000a84a9afc
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ce4a992-c530-4231-0712-08d85ae2aaf6
x-ms-traffictypediagnostic: CY4PR1201MB0120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0120CC99D2AFEC4B9270DBA5F13E0@CY4PR1201MB0120.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trApIGww5F9FnieKQKNeqv0yv3UFTL2I4ZRxEmE0JOvW7+Rrn3h2X4clR/4fUEjcXbAg3rbDBiOQtRH3yNQFzhJgm6cWVdRYI9e4IThRB9NG993FfapchmZCwIPOPGD3yddDxwqAtlHP9Evtaimgspe9JUxtRO4hI5sM0GN3yWjA4By8wOXTp4yK3SHIjsVcng0Ttno/r70Qfi64BndpPNKLUIo1bmyX0idM/4czJ+T9u1Q7QuupK/Jav/+Snl3bg+X+Eir50NuLhFb11l3abrrfjylMLXoPz+3Ixvto7i6QjMA2m4kjJPZRlmhFwJsZbBAlBPZMVR89dHdf6Xk1faTRVoPXi4dDOktpQLw46wI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(86362001)(52536014)(316002)(478600001)(45080400002)(64756008)(76116006)(66946007)(66556008)(66476007)(33656002)(186003)(26005)(83380400001)(71200400001)(5660300002)(55016002)(9686003)(966005)(2906002)(53546011)(6506007)(4326008)(7696005)(8676002)(66446008)(8936002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: XYFdJIGf+Wvp9J2eDFW4SfvuO1jqL1RLNr+z8sBYqmOsm+G81KaLBw02UXybtOJwd+M2f2Nyr5n2R2JD39QMkBKSbsPHENsyXsIBzOTzGSG5K6WNso6KsVuhUahU0xQ5fILnH6GHyZtCX9ycGAfevQHU0vyz+Kj3y0HslUMjk5Fm59/OoQrI3c5RS/0FHMH49ryJk1QyPXhYByISIk+DjEGplwXSY50Ei+NonfBtfYwnjjmRa+lhdIstrww2PD2mfoQoDxQJp/LNi4pO3oF2TonUmBAlV8f/V6qboS1WyXPp+golGznVzp1neW86h1vbYr+RALimwFJNYxpiCSImV7zYqIb6dYKGvJGS97cbkbK/Yozah2V79AHaNJRhQliUSbK7PswfcILidQMNNxRVVh5cK+7bDZOQbKlAmzw7KMV0kkyDhgplHYbN4f6cPISBjMcF0J6Gk64UNfCdfSy8PLrsnscJ/3DluoZBndDXgv5zkwTrfDMPtufWxR17NJ0lsVc8yF0gOP3K3cWpE9dAFWKaTkl0UkKP3HNz9Q7AzQ5Fv3tqfpAreZSSwzqQO99u3Mqls/qXIf/r96ApYtsx65KRaWm/A9ZkvwETCvHClNFVi5IfN4OuDkRHAw1oJA/elbE9ap9LbtV8zud2DNEmzQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce4a992-c530-4231-0712-08d85ae2aaf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 08:21:24.8984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWbjYIBywcLDPkCQR8b8XWDzHcDRlSBaD1+4Ziar7elbY90qrAIl+OgvHKAzSGyWnzTZ2Bgm6Zm0vcEK2rXuGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Why not moving the check in smu_post_init, and return 0 at the first early stage if it's SRIOV case?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jingwen Chen
Sent: Thursday, September 17, 2020 4:11 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV

smu_post_init needs to enable SMU feature, while this require virtualization off. Skip it since this feature is not used in SRIOV.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5c4b74f964fc..79163d0ff762 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -469,10 +469,12 @@ static int smu_late_init(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
-	ret = smu_post_init(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to post smu init!\n");
-		return ret;
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = smu_post_init(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to post smu init!\n");
+			return ret;
+		}
 	}
 
 	ret = smu_set_default_od_settings(smu);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7C7bc132d80cd34c4e7b8f08d85ae1fcc5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637359274256715319&amp;sdata=x%2Bc0jbDbTv8PR7qj4GCbYgxorKyFg2K%2BJYgcrs4iftE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
