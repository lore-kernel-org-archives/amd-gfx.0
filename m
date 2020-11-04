Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B77C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 06:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C3E208C7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 06:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Dt/Xhwvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C3E208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0897D6E94B;
	Wed,  4 Nov 2020 06:19:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB1F6E94B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 06:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDfrOzriqQ/XYbENovULkOZ6/be7ayYwjvaRwB6/JsIrfGAkzjtouNlStEjh2JiXmMKVXaCSe2Wk+y7iwd9VpX3/gYPZ9Ce/cOy5nQeTps8/yrsZoZH3tvTz58QY33hgaq2LvAxox8jTgBSO40KoNFtVW4UI0+JVrp6MJ8tPpW0EZyxqjyZM4T+Ne8auC1gLLSY3tbOo0D1xsg4I+0uzqher+S8iFDxFmtRSh85w3ZiLq4PzMOcjtf/T0stpM12LweuD16T7Xh/MlFArDNdYzgN3t+ITS0MysOPcSicmYornztDseIWomObsE4DpM3DEnNttX81YCbOB2vYYDhFnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YCypSU0KL/3L4Gb3dDsJh2hcru3wbSrZHy4pesMIQI=;
 b=QoBFcc3QVk96A5zbpRLVaQMt8k1tvqCc+Sqa0NbuV80GXg3997chSgtCMn2fQlAeeMOuQRfCS+hypmeowCuG342h38J2w6hULUiHlOUL/lEHJaLDP/6Nx4COFxUeTGqpLTLRW0SQtJYGHWqinf0d67b3j1Z71LTNN+n43Uq9JIfjOPRhfidpmjXAIIR4PoF+9rC7z9rhTtg9NswZ1oacTbn2lDv0/mzBQG7IetHlUo3ZQDoxmhUOfeLPVKUG2I0VMEjm4w7S0yOiSl5sbyqBxQdT3YOXJc4VB+02xpxYnROwwpm0hcrSWE0iafOI71TbqEAsV7Ca/YSo5JVqrD04Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YCypSU0KL/3L4Gb3dDsJh2hcru3wbSrZHy4pesMIQI=;
 b=Dt/XhwvmmicFV8O97AtjP9RRt81ODbtnDOhDLoaN76/XIKYafRY+ii7A8ntVzAOPydNKYkY9Iscn4jEeqhX9QLu4sJFnWRj67SQonYAGHD+3ftP/zafGj2jGIsehaZiNEWdjzt/1ftvqranPUoc+6A9bZYk2diY+JjTaPV1GoIE=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19; Wed, 4 Nov 2020 06:19:44 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 06:19:44 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: cleanup debug log in amdgpu_set_pp_features()
Thread-Topic: [PATCH] drm/amdgpu: cleanup debug log in amdgpu_set_pp_features()
Thread-Index: AQHWsmhnpoJ9Gz5IZ0qly11iihEM8am3gBwg
Date: Wed, 4 Nov 2020 06:19:44 +0000
Message-ID: <DM5PR12MB16574B059D6FEE7224FB28FC8EEF0@DM5PR12MB1657.namprd12.prod.outlook.com>
References: <20201104050609.20571-1-kevin1.wang@amd.com>
 <20201104050609.20571-2-kevin1.wang@amd.com>
In-Reply-To: <20201104050609.20571-2-kevin1.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-04T06:19:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0fe45342-88a6-444d-a68d-000068d592c6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-04T06:19:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 29f69ea8-9bac-461e-965c-0000a9c4ff11
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec93f0af-671e-4301-e779-08d880899f47
x-ms-traffictypediagnostic: DM6PR12MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4497E3ABB0114E03A64DA5938EEF0@DM6PR12MB4497.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i5KuQXXJyQKQg6a0AyhOWb2FFELrNxrp3FuZmo1MxqBfOY7slsOwIC+tEs04+bjDGRGTQfwE45ba/+Ii0cRmizpXswRDmsWseDk/Mj5/6OoYEUJrkFFrwcu8XFGHy72lBpop6mz2jD9Oaer8TyzEmsyksGbGdFzZoIjgZSA9Wguup4qcBfuOJWznqJXNYhqup1m7w0fLOkXx3jsIFNei92+zqjvv/5zxT3E2EyevX+UjG0mS/sE5mbLMDSGBWAKxGyeMaFA/1fHYehGw6b+l6IjHyD5Y6AHKIiHEw4hhKLYVFsccuXjV0v1sZZwvdI3pdomyB53f75A356iCrtj2n4ugU74YnhcQquxTEk0ajPM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(26005)(86362001)(316002)(4326008)(54906003)(66946007)(966005)(53546011)(6506007)(9686003)(55016002)(186003)(76116006)(478600001)(7696005)(110136005)(33656002)(45080400002)(8936002)(71200400001)(8676002)(83380400001)(66446008)(52536014)(64756008)(66476007)(5660300002)(66556008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dIEZfXiLLFQQehfQonKb6idnUtJs+X0396YTKiJPbepOkKyxtipWjD0ZDfNQV9fWOYXRNMfRe/dwvCQk/bRWjf6Qg6hCnbcPHLnz2YzPnq8+flB69WQ4RuOFp82Ey/iT8LAc7foBbQRtBK9vqP2SqMCqd0HDy7gbrk2RQtcdg7VmSuSiCuUXwYKBOCc5UWkc7VO5Ip4mVeEAarAq87Wo1zW5MtVeuX+MZsqWsy50uG59abcIZWwMN+/LaJMTXkOK/LCfhtAW6QAp+JmJ1OtxDHhJO1Nsm3HPuUwaeYO6eqNUzui2AzjkNgLqpHzROZ9En+1jSAorqNEdMlXbm42vgb+H5R+3v0Dr0JFaOOcXTAE6r52DONmAhmgXUwD9j08+Qb+Df3J35342xe7fUJojySBZhk4Y7m/E3NIrozMb2D9domdKcFCCElhaDjdialx7zeNM8lTYjTvYbdKCf5brTHUcMgoS243Oqchr8k3UPHRXweTg2/wiy2Vq8Mk63ZLHFvnfS3KQ13FFdzygQqmrK0gywyo9RsfDy7qO+82p7JvJ9ZKIGKk6phRaZ0NCU4nWIlTnHl3Z42RNP2zo1CMoSeGdNY5BAfBeLFHeRPHl9AugY3KwpZ/EDHdU8IUDCYPUyTFzSPcOakP425lZGKeTtg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec93f0af-671e-4301-e779-08d880899f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 06:19:44.2710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaKBRglLfzOFkdhL1c/ypXYBxYsOmRfMtmnAkcJQY2kcDZ8ZfAac3HUsG2OFlqOS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


Best Regards
Kenneth

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Wednesday, November 4, 2020 1:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: cleanup debug log in amdgpu_set_pp_features()

[CAUTION: External Email]

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e57153d1fa24..a33b1cc50008 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -941,8 +941,6 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
        if (ret)
                return -EINVAL;

-       pr_debug("featuremask = 0x%llx\n", featuremask);
-
        ret = pm_runtime_get_sync(ddev->dev);
        if (ret < 0) {
                pm_runtime_put_autosuspend(ddev->dev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7Cc0dc03218d9743e1644408d8807f66c4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637400632532649097%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=1fcM0zHg1fuiW8HqrEsLJnjAftkn7VY9lnIQAgGm64g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
