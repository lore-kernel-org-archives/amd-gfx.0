Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1D9C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 06:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434432075D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 06:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CRR8EKC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434432075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C666E200;
	Mon, 13 Jul 2020 06:02:02 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9EB6E200
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 06:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXpBrZRfR9wgdz3BLMtRjfB0MW0/Ia0vMTSXmAFWZRnqbPkUFHJ1MYwdnerbcBW2qu62tlvsoAg+DEH6I1FdcgTdLvfNAoewXIIhSGCh00hQ7MIaSR4nre9BGKGgPtYzVMhnM9XvlJJkR59/ANqCn4KOiu6vbhw8Igr0mY7geqSvGdmo1kVIn5hRLUz+Hg/tTpjQzz3aSIdXnGC//4hjKZy31gTHiqFlb9/syxIgPoG4sdMUqKEvwJ7LhQyiTpKqEVLyrK6LkeyWyMIStnB2/6S4MJ3ErqHRlWelFXLIXZ7ZrKFKipdqcixMy5wo5Pdp22MwBnKLaEahNGw+W52VIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj+BkRdVKXDdjGQvp40Rpfr8uO0l513fsb9DvHEsDpk=;
 b=YY3Z1EjlDjJhktUTIsLuER/MJMIxMN+ZNiiaVWF6rQ+3aveptU8QGvt0pK+gYricnbueD0Da9BvzWWZA0yQDWLrZApySNEeUllWIz8qxhvQv1ui2+JlnU+V9s5+EGM7UVSk1w49ezb1yxwiCPakLJZybIVBjOM3b2t1MPCsUC5Rjbe7qXpy/59t1LxL1NhsVtDptjP07DtKHUdDDTZeba/dsN4685YzSCP55ZE/EhcMJwXm3Kbjnowfu+NkRX2Jdqd00ipKJvX+Z5fnp77U0Yod4PyZaiTDIIvZN1ed7/bMFnloY/wBwFRUXbImjBiYb4FgSSJmYLAEUWVTFjrA9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj+BkRdVKXDdjGQvp40Rpfr8uO0l513fsb9DvHEsDpk=;
 b=CRR8EKC6CvTz1hm7f0TYofJDjBnywxhNTrc6rACjaZDzX3rAlRTR9s14ip0lu2cmNDHLVz1D5W4ODfLI7Ob42DpOyvAyjgUso4jQdpghtojGo2UZd+7po1SYyqhJharWk2WX8hxJt+GUfhF4m6jXW+esdnt2S97u6Nt2eqs14cc=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Mon, 13 Jul 2020 06:01:59 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 06:01:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs files
Thread-Topic: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs files
Thread-Index: AQHWWNrlNeu00SfTFE6n/QU27yLuaakFBFIg
Date: Mon, 13 Jul 2020 06:01:59 +0000
Message-ID: <DM6PR12MB4075265F429B779C95E42C47FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200713055950.19611-1-xiaojie.yuan@amd.com>
In-Reply-To: <20200713055950.19611-1-xiaojie.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-13T06:01:56Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2e9eb629-68d0-4bf6-a857-0000a7516052;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-13T06:01:52Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ad828da7-f0bc-4493-9e64-0000bdb2bc0a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-13T06:01:56Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d69f1604-25a6-4e9b-89a3-000044b7d88e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a0a948a-088f-4593-357e-08d826f241b1
x-ms-traffictypediagnostic: DM6PR12MB4337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB43374992871ECD3AC5E7D7FCFC600@DM6PR12MB4337.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EVJP/tv+5aAq4n2yO88SoBGSVWSj6GICvOwf7GcUja9IufBTtNJnsnDcFRYGHc0x/tDU3THtAwPcrKzwKqIuTh+868foo2tc4OD1fSfW/BzgSrgb7SkR7W9bFH24K73XP7c2KV7aqgnjHC8RcZkz2JdC30y2VdrhHi7GMpisunQ2hc0PbYxTY40ry8ruSnbQJ+c/sYsOdbv9OJiLUN2DMn3aIghuHLWyzs8UchpCTmhddBObnYhFTE6T7LgvQCIa4UvbzMUwhGWHH2xhJzDhK0sYSr7WSnnLQw7ZpURuDRxIwzw+hLVArfpiD4bIjW3o4kX17uajnDfC9I4WrK7sAT0ePeK1yewwAJCF8OZuY+w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(53546011)(64756008)(66556008)(66446008)(66476007)(6506007)(86362001)(186003)(71200400001)(26005)(316002)(8936002)(7696005)(4326008)(110136005)(76116006)(66946007)(966005)(52536014)(83380400001)(9686003)(5660300002)(8676002)(45080400002)(33656002)(55016002)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: aa7SnjfRZs1tUnFhYbuG50Xosp9bFGcEsAF5ZARAEHPFxYigPH5CzQYReqMWzRsi6BDAL82Hi1KIceYl5Z+D+bvjnjhn0oP6ycxPghSjOBKNA6l6a5vfa9/QXhS3PmptCGL4KRShPkxpoVyP7JOIDWLG3F3vkj73VFkhhFXbhEe4P+5cwNUZw9V/TKl52YTdMLs2OrHJ/jptcGFIxVnIuOAMkdLTCy3DzTArRUw3Tg5tcB/qOSL4/TC1D4A0zJv2l2ap4u/g5XYw+6pm6QaAeaaLRU0sKTr+iNzs4fGtKHSd/7XgxyFlxxc5UFrSdPtRodXE08ZBJSF6lARraqe5sbbFkw0KuBBxSRT6JUnsRK2xyayq/vl164j+LtJjTqnAO50SkiRF8PjJGUAt7//3wRj/4zZx5M8P8v7F3D3vozNQQV9yON4LFtlqE53wJhhdnqloGtdcF85PJabES2G8ZAUkdt+D4FtS0phzOftR7rn6tn08dVDm2lFh9b0fQXlU
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0a948a-088f-4593-357e-08d826f241b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 06:01:59.8720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lW7qD9tnQNQlMvTq91Qrc/KuhyIVgfPI7NFbuXgNXA0xoRmiqE5MU1AqvpowgqWyV3gfOl9BRFQDgTuCrM3QUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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
Cc: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiaojie Yuan
Sent: Monday, July 13, 2020 14:00
To: amd-gfx@lists.freedesktop.org
Cc: Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Subject: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs files

to easily add new debugfs file w/o changing the hardcoded list count.

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index b8ce43c28116..58d4c219178a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -781,8 +781,10 @@ int amdgpu_debugfs_fence_init(struct amdgpu_device *adev)  {  #if defined(CONFIG_DEBUG_FS)
 	if (amdgpu_sriov_vf(adev))
-		return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov, 1);
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list, 2);
+		return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov,
+						ARRAY_SIZE(amdgpu_debugfs_fence_list_sriov));
+	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list,
+					ARRAY_SIZE(amdgpu_debugfs_fence_list));
 #else
 	return 0;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 77d988a0033f..8c64d8d6cb82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -928,7 +928,8 @@ static const struct drm_info_list amdgpu_debugfs_gem_list[] = {  int amdgpu_debugfs_gem_init(struct amdgpu_device *adev)  {  #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list, 1);
+	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list,
+					ARRAY_SIZE(amdgpu_debugfs_gem_list));
 #endif
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 4ffc32b78745..dcd492170598 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -468,7 +468,8 @@ static const struct drm_info_list amdgpu_debugfs_sa_list[] = {  int amdgpu_debugfs_sa_init(struct amdgpu_device *adev)  {  #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list, 1);
+	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list,
+					ARRAY_SIZE(amdgpu_debugfs_sa_list));
 #else
 	return 0;
 #endif
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C22bf311806fe4925f70c08d826f206b6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637302168223168477&amp;sdata=4U%2BsydWtuJp3XUmMmB9H8ApnBORKYF9eL5yRBjQgYa4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
