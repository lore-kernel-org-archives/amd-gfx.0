Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7307C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 03:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72610207DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 03:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2ipXm4DH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72610207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22DBC89CE3;
	Tue, 18 Aug 2020 03:25:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD8089CE3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 03:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/6+ftjzlcN42wfNGN01o4nDYNKIHd5P9M+WomRB50nqB5W23Aa0J3S0Tj9hjC0YIWWKgjlQxhxTmlqObtbedXybpEJincNjSrscxBgEdM12PWVsnyuMQY+FUzPKBRo57OG5UPa6d6do0D6qsnxr5OCesaDf4/1HvhPWgXrQ1wOKbdqjrRhZQPe7WoU5pnvwzS8MBUH3XdpkOgnHOvQ5QV8ONm3CzrQnvZzh2BzWOaIpL7KpXZ7GbkDnAL+TOowRW6YxHD/iWZzIM5u+iauLKFGSUqmltjlVBoHDfa4Np7otposuycExvUCHa/JUj1NSSIMEVifE3jlZLzGYGpmtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmElEzKuNovxcLWKkEHFTrDkBVLtfkKXwgD+uhg646g=;
 b=WYqRj5Q7rOppCjP3v82tW+L/8MBx33SOljNL0Ofh9DSVsQy+edbWrnJh1gsNUxcPz8Y2XVnKTvtXbG/1WzL6DI1ixQDrgpucyQT9vXDtZM/tWHjSYMYQhOebOpXf/PYLRd2HcR0Abs8W1vUXV1apgo7kwmOWajct0JZzRJX+9Gf3mr4EiLXxxJ7F7/9i1kRll1C6w/I+VJcPrsJiiG9BPQZLHvdvPfBDkSAZn8x1NXpk6gQponzMFud2EQfzfuPQF7wxupiKffRaSlDDJkC1KxRxy/6wj8p02on6pNP3b7oHWYOM7HzD5e4bARw9lyB/0ZXOI02u4H8TX0KHi9CHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmElEzKuNovxcLWKkEHFTrDkBVLtfkKXwgD+uhg646g=;
 b=2ipXm4DH9yMqXSoY+C+pJh/gwnNkxcILJ59jRQrmRUguU6xRXUDSn70II+QP1LD5FTSfJNdH2dSDcmv7ygnojNvRZ1k680JDFVqKCqFjk306Sy2uzXmkmleWzA8l7Kslm/66NXeZxlzkPRA8FmtGVbzguHC8rdEaqgW4dTjMG6c=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.27; Tue, 18 Aug 2020 03:25:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Tue, 18 Aug 2020
 03:25:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu/pm: only hide average power on SI and
 pre-RENOIR APUs
Thread-Topic: [PATCH 4/4] drm/amdgpu/pm: only hide average power on SI and
 pre-RENOIR APUs
Thread-Index: AQHWdNAf+kBPB4jSVEe9z7xlB3LKC6k9NMIw
Date: Tue, 18 Aug 2020 03:25:29 +0000
Message-ID: <DM6PR12MB2619C5F6BB1D6ECE47AACC5CE45C0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200817195329.1971490-1-alexander.deucher@amd.com>
 <20200817195329.1971490-4-alexander.deucher@amd.com>
In-Reply-To: <20200817195329.1971490-4-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3b6d10fb-48d3-454c-98fc-3deb8892969a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-18T03:25:17Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e2bd514-c8eb-439c-ed06-08d843265ba1
x-ms-traffictypediagnostic: DM6PR12MB4355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB43554C2E1C2537AB47CB4991E45C0@DM6PR12MB4355.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtA3BwA4w6KTfTiueoyu/g+oTzS8DDLzGMsNtALXPUz2/NHLV1uEG6Wep04XLhYgxEkjA9KwXofVq8PTQAZxDT5YU46IeuHCHC1zLAvwtFXDuRUOUAMKGtzh9uLMuGSp5RQAKSNRI3f6aMbl1+QEeD0KZIEuGuACq2BIPplJBMUyYa/K5k6v+Rn5F8UlPTd/kHfnP5fUNYH9w85ur9GxfcCOqGYVedq58H+F4DQCSycx94Qt/7G7WZRFiM30AIb5RcbZuBdQHmy/xB848ikTNxHaYZJkNA8svlQuxjnBpB1Mjx5k5Afo2t8ZTZhpvjVchMhCNOnG9Jcey6SUtZyjHOFSgLqiwK8ZCDwvhEQXecY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(478600001)(53546011)(186003)(52536014)(966005)(4326008)(6506007)(9686003)(26005)(7696005)(55016002)(8676002)(33656002)(8936002)(45080400002)(2906002)(316002)(66946007)(76116006)(71200400001)(66556008)(66476007)(110136005)(83380400001)(5660300002)(86362001)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1KQy9sT4KQpqkRvW0/OAlWpG/U5w7DKsZ71U6qEj5yHuZ24TAj3r5hJ5s6Pn93qumGcsminDHTfXYrfqJNMgUybKV90scyT+u9LcBiwOMaD/EDp5uHnHo6ybLFS5X3JiP58t4/mSFL1thP859XtsCTFVTncpNH9detdl2tEYe3Slf5b6PU7+N5O/yZpxmE5zKcX75zSxY/Ze3QDGdTYzk7p9HPnIMWlVRjH1WLa4qzyzMX3TX6amXhOPQBTznhm6Fv1cW3ZLNi2LlBWBggGwt4lCTR7pqywtoJidmirOK9heZpLuYw9k1n0e2xPt8fpT3jLb3diW7Vt7zxu4Jgc8QN17mTAzyXs5Q5Cx7YtZqWed7mWERonjRz5aAThZZSH1U6AC+GhVRQlO23jNEerpOuiVDZ6MYAS9gMlvrjx6rYTQvjs8/369HhbAhti1/aCEMBXs5DztazfOS96aFCP7xp9YIbS/OqidTt7qlHNog9QJr/xvQPzs5L+wt3S5FORRNSQCuJBSG0k98PEUx3GTpb4Z3CGUvcM1FsZ7MSOJdcUku5TOJarR3fqvvHgvlmZddNUY9z6wML6vGSArSI9rLfJglVCCruc7298iqpIQ4E0p1vd6y2gKUKR0yLxwEorhEkBeVuYa/XHVjlEl/YP4nA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2bd514-c8eb-439c-ed06-08d843265ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 03:25:29.6622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+hx1hZySriyPc2DJQLbxAmUkSELHTeipHzCiT3TEkwGMkj90/LOdFaphPn2vWgd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, August 18, 2020 3:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/pm: only hide average power on SI and pre-RENOIR APUs

We can get this on RENOIR and newer via the SMU metrics table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f2e70655e8d9..a77f7347fdfc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3312,12 +3312,17 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,

 if (((adev->flags & AMD_IS_APU) ||
      adev->family == AMDGPU_FAMILY_SI) &&/* not implemented yet */
-    (attr == &sensor_dev_attr_power1_average.dev_attr.attr ||
-     attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
+    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
      attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
      attr == &sensor_dev_attr_power1_cap.dev_attr.attr))
 return 0;

+if (((adev->family == AMDGPU_FAMILY_SI) ||
+     ((adev->flags & AMD_IS_APU) &&
+      (adev->asic_type < CHIP_RENOIR))) &&/* not implemented yet */
+    (attr == &sensor_dev_attr_power1_average.dev_attr.attr))
+return 0;
+
 if (!is_support_sw_smu(adev)) {
 /* hide max/min values if we can't both query and manage the fan */
 if ((!adev->powerplay.pp_funcs->set_fan_speed_percent &&
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cc72834b8042146132b1c08d842e7406e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637332908288049501&amp;sdata=5mKxWVSyQDY1FukBEDZRCQFgP6JYO0foHN9ialkkWik%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
