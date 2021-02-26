Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F45EC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 13:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76DF64E6B
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 13:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76DF64E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DDFC6E11F;
	Fri, 26 Feb 2021 13:39:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01416E11F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 13:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhML5ZrrxW+NKf7ozu8clQlMNiWr3fRhImIGxGfQaKAZj7Br5G/llElW1JmstFjGnp+Hc5710JUU1V5lCB3bBgx5ZxtxX6YpFGAD6aEEQ+0IToRmHmW/vpWoodRIrswgQiKcrURungmAGEnmM/KwmvFz5zMcsJJ8AbaGSZKDSTxmE9VD6Re0EIHKjzv7elLyTcERaxdis5rw94vV+gpyQ0iwWnRvT2fYQwpEgDSFJmBiBnd3T9vZ5ve+M85spnniBTsBUChb+y9lfJhqnGaqbWP8XS9XmsPYrjbGaIHcBu+4clv7Yix8qlXt1bIW9uNMXbDNe2oLEoJYvcwJx49tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6k5BbfVgtWf0uKQ1YSI3Y3QZ5DKNouzo5OYei+cGuE=;
 b=dSPxF0lpwh5zhmZ5BUYnjB3f8qCRNYOLmh3VHV6S7iFYyY/yOgtCPa2Lf61T3Z+dWnWAKBeh2j02pksANna8owInNhVsVypH5v6XRWYA16aVlI33kbac+206ZCCh3cbFt0qtrj4fb5yDb8ghj+0dDWJxQgrAhVedL/7MQf3rDg4BmYRe950AVZ8pMJRatcc+tX+MQXDIoeRMnoBmZmDFXBQRLH2WtQBza8eoFx2fwfugH4FFo4e3iUr3z4y+ruHRtvzLyRK5cnRVXHSoDgxaWhp+Czu7ijad3ltLnyvrkIw6ltAWWE7nakSxg8hVYmXwiH+ldwTWQpjk+ndE8kQzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6k5BbfVgtWf0uKQ1YSI3Y3QZ5DKNouzo5OYei+cGuE=;
 b=OZI7lM60PJbMDbSk32X6xsnybbVbeLvU17yNR/d0R6wTnBLq/iDWsVzfdRRWuJNcR6zZFzHgjpXbBEOcgIjp7AU/hIjn/jpCLBCZrDu4KI1GgczgKyYYW7/ocT1iSi+bTUXx1rzHcWDAoJXzu3K6xGq1AoFRqvtVgzPq6rUdDvs=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4994.namprd12.prod.outlook.com (2603:10b6:208:1ca::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 13:39:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 13:39:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
Thread-Topic: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
Thread-Index: AQHXDAkUlXu+rLfCL0KJyg5tQ6Z6rapqcW9H
Date: Fri, 26 Feb 2021 13:39:42 +0000
Message-ID: <MN2PR12MB44881D97DF9DB89FC4E92507F79D9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210226063122.9902-1-horace.chen@amd.com>
In-Reply-To: <20210226063122.9902-1-horace.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-26T13:39:40.887Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b12dc1f-588c-4f3e-222a-08d8da5bf8a8
x-ms-traffictypediagnostic: BL0PR12MB4994:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4994194C2D07056333275355F79D9@BL0PR12MB4994.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1V7KIHGctqgY97KlbMi4LLJOjDBY5ojcy+i3gkxVuIgYUz8rZuy/9fKJHaOXD17tKo8aYjjqwcolZ5zWELcL4SUtxFXypLS8eJCny9nMCWB/dtpqwerAtK52dDvE+xSWjVIOGL594m+u/SQeLDaQ95Bi6InSoJAql9Q4F5mbJ9lOaWV5NqM9Idz6+xYcV7QHKjbCB8CMjsye1I1eL6gK9e70BN9tWMsSLtfzsZdsc6B/mU2raP6dPcUXwrq5TdVnYg54n3TeXCEzIlr35N37mcLwm3iacrRstkGyxohrN269JQXiyqz2nREzz/OzGyFz6nNcIE1x22KJ9yoGu/LFA5WnIED/rz4FRD6uUNAtbrUNZoyTSunp2ySCXsGQYKuXNHVShymLaNFD12K/2w5gRnFgYg3MXliKeunKSZyOJdNN8MHLTUnakxlq1LkAsHlOpa1HHa1jdPwP9Chy0D/uwujANQnVQUta/t85RmMB4WDmRuPUWy62/w+QkMBa3Kgaf9xsd8oPcSe6uF7xt/gkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(8936002)(2906002)(26005)(66476007)(86362001)(7696005)(66946007)(64756008)(9686003)(316002)(8676002)(4326008)(5660300002)(53546011)(55016002)(66556008)(52536014)(6506007)(83380400001)(66446008)(19627405001)(186003)(110136005)(33656002)(478600001)(54906003)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QqerRPUMWAxTj/H7MR5CO25Nler85GH6mflsx6dQYYcSf5g0B9aDxlRAAaiA?=
 =?us-ascii?Q?8m1KcEd/ws70uX6pho1VYJydK0nVDtSayrjMzN9t7tWiVdsvhuKD1Mg9Ui/Y?=
 =?us-ascii?Q?pYlk43Mqv0LHGgKw5gTwI0NBGLKgLfE5VS5vpdSlVYUMAYiEMl2k+exyKnNM?=
 =?us-ascii?Q?qqMM1tMgcFUXOWT/9VlyOwf/Pen0RDf9EaBtttZ9yZGMOZsdc5E0WEwh5U/d?=
 =?us-ascii?Q?WPT/13r7GRaH732imJPPLqVnSIN1dU0jdr3HegcSwsDse6N470Fc1FhsnrGp?=
 =?us-ascii?Q?s+4Lm57eQnU30XpLqqH1XwTXuGbXfGfFHGjW6slsTzpb0uZl7glS6fiSRRTY?=
 =?us-ascii?Q?2lXGk1wM7MFGVb14QakC7TOxIJSkg8XcuRIF0wLV+1QbGf4aOnCtOWVrIwZZ?=
 =?us-ascii?Q?3jlvL26rCfcppm2ruNzNRot6bJ91gCBHpR7yyB/eM134ZdxoY46m77j5iohO?=
 =?us-ascii?Q?cx3MhoJ7c7U5sXa8+GpcksQiI7s3iBAK7SzdGRV9ngudlhvvKksHDCeL5M7x?=
 =?us-ascii?Q?PMx2fHzaHDLOA8oyTIY2Pt3WFzs8JOnegSCsCU/9NtuurlRb6iZPelaa3eEg?=
 =?us-ascii?Q?y4UFQcYR+6sTQa/vwQywAvmEMDqzO+1FglZ7yN+cjThGbVqBJrMT+VFGKsJ8?=
 =?us-ascii?Q?G8UBTMW/6NcptfHz/jICtNQVvQL7zWJfiShOCzn0oAwtfgmH6ndu7KwqGvKh?=
 =?us-ascii?Q?s09YuhScR2Id/SutRICP09ULtwVdGHsjlnoQ3CCmxNLXzFnE2ocsgQup0U0b?=
 =?us-ascii?Q?GzPAkaA2TxcbVDKjdNQoRcpDamQQuQgEUNnD7+nGZ3ZgnjVnQ1sQDe2U0TPA?=
 =?us-ascii?Q?IGjFFhw5clDJPeFJUUEmc+3TLwZCxI3GeIkYH0Utc7+1L8QV56CYilmzQnWp?=
 =?us-ascii?Q?VlzCqNzNaO7Dit4j5Jl1g2a2j7AjEhXvX0u46qQuhZOlvpaYFmxPelbpZrBZ?=
 =?us-ascii?Q?icdRtb33f2oPbqL+7PkmAABa4lykxr/kUOLjGMOEoz6qRshZNnKK4wt4dKJA?=
 =?us-ascii?Q?xI/ul5Zta4Vyd4ODOMajtnBIgtR+Yfubcj2c+UWlES5Ax9+figGGQq17AnLP?=
 =?us-ascii?Q?V9jCrHjZk4GWzChYHus9KvZBclrIMjQuA9c2VZKoIabXHzdfFyolYp9jtb6u?=
 =?us-ascii?Q?kbKkivRV0qe/rsZY36vqBwgrazZEiQOOIttHToyBHaz8gWB+sdH4v36hW8dr?=
 =?us-ascii?Q?ZIJqMm2Okr00p4O1+zsylfc+2zuIQSkmT2EqEQRGdvToZgPQACcernqOOqXt?=
 =?us-ascii?Q?d6ASR5AYBb1EdcXoIc90Rlu7DqtvHyoZrSzgSaxhO9E9u+OgeCjlZMFc5vq3?=
 =?us-ascii?Q?tJibm3Js3RfMqVKlnnayfrL5?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b12dc1f-588c-4f3e-222a-08d8da5bf8a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 13:39:42.0318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uv9ZEbpcptdvrjPbtyMdRTtwEnNcpw0aVn20UUDtLDCN169kuiE4l2LVwgbzoM/U0Ju/cOAr8Jp1eOqmAm4MPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4994
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0020437517=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0020437517==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44881D97DF9DB89FC4E92507F79D9MN2PR12MB4488namp_"

--_000_MN2PR12MB44881D97DF9DB89FC4E92507F79D9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Horace Chen <horace.chen@amd.com>
Sent: Friday, February 26, 2021 1:31 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@am=
d.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <A=
lexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <=
Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu=
@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.y=
uan@amd.com>
Subject: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf

sienna cichlid needs one vf mode which allows vf to set and get
clock status from guest vm. So now expose the required interface
and allow some smu request on VF mode. Also since this asic blocked
direct MMIO access, use KIQ to send SMU request under sriov vf.

OD use same command as getting pp table which is not allowed for
 sienna cichlid, so remove OD feature under sriov vf.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 10 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c               | 12 ++++++------
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f0f7ed42ee7f..dfbf2f2db0de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2043,6 +2043,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)
         adev->pm.pp_feature =3D amdgpu_pp_feature_mask;
         if (amdgpu_sriov_vf(adev) || sched_policy =3D=3D KFD_SCHED_POLICY_=
NO_HWS)
                 adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
+       if (amdgpu_sriov_vf(adev) && adev->asic_type =3D=3D CHIP_SIENNA_CIC=
HLID)
+               adev->pm.pp_feature &=3D ~PP_OVERDRIVE_MASK;

         for (i =3D 0; i < adev->num_ip_blocks; i++) {
                 if ((amdgpu_ip_block_mask & (1 << i)) =3D=3D 0) {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index b770dd634ab6..1866cbaf70c3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2167,7 +2167,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *=
dev,

 static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {
         AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           AT=
TR_FLAG_BASIC),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index d143ef1b460b..7033d52eb4d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -612,10 +612,12 @@ static int smu_late_init(void *handle)
                 return ret;
         }

-       ret =3D smu_set_default_od_settings(smu);
-       if (ret) {
-               dev_err(adev->dev, "Failed to setup default OD settings!\n"=
);
-               return ret;
+       if (smu->od_enabled) {
+               ret =3D smu_set_default_od_settings(smu);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to setup default OD sett=
ings!\n");
+                       return ret;
+               }
         }

         ret =3D smu_populate_umd_state_clk(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index af73e1430af5..441effc23625 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -89,17 +89,17 @@ static struct cmn2asic_msg_mapping sienna_cichlid_messa=
ge_map[SMU_MSG_MAX_COUNT]
         MSG_MAP(GetEnabledSmuFeaturesHigh,      PPSMC_MSG_GetRunningSmuFea=
turesHigh,   1),
         MSG_MAP(SetWorkloadMask,                PPSMC_MSG_SetWorkloadMask,=
             1),
         MSG_MAP(SetPptLimit,                    PPSMC_MSG_SetPptLimit,    =
             0),
-       MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddr=
High,       0),
-       MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddr=
Low,        0),
+       MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddr=
High,       1),
+       MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddr=
Low,        1),
         MSG_MAP(SetToolsDramAddrHigh,           PPSMC_MSG_SetToolsDramAddr=
High,        0),
         MSG_MAP(SetToolsDramAddrLow,            PPSMC_MSG_SetToolsDramAddr=
Low,         0),
-       MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2=
Dram,       0),
+       MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2=
Dram,       1),
         MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDra=
m2Smu,       0),
         MSG_MAP(UseDefaultPPTable,              PPSMC_MSG_UseDefaultPPTabl=
e,           0),
         MSG_MAP(RunDcBtc,                       PPSMC_MSG_RunDcBtc,       =
             0),
         MSG_MAP(EnterBaco,                      PPSMC_MSG_EnterBaco,      =
             0),
-       MSG_MAP(SetSoftMinByFreq,               PPSMC_MSG_SetSoftMinByFreq,=
            0),
-       MSG_MAP(SetSoftMaxByFreq,               PPSMC_MSG_SetSoftMaxByFreq,=
            0),
+       MSG_MAP(SetSoftMinByFreq,               PPSMC_MSG_SetSoftMinByFreq,=
            1),
+       MSG_MAP(SetSoftMaxByFreq,               PPSMC_MSG_SetSoftMaxByFreq,=
            1),
         MSG_MAP(SetHardMinByFreq,               PPSMC_MSG_SetHardMinByFreq=
,            1),
         MSG_MAP(SetHardMaxByFreq,               PPSMC_MSG_SetHardMaxByFreq=
,            0),
         MSG_MAP(GetMinDpmFreq,                  PPSMC_MSG_GetMinDpmFreq,  =
             1),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index bcedd4d92e35..d955dc4c6998 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -73,7 +73,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 {
         struct amdgpu_device *adev =3D smu->adev;

-       *arg =3D RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82);
+       *arg =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 }

 static int smu_cmn_wait_for_response(struct smu_context *smu)
@@ -82,7 +82,7 @@ static int smu_cmn_wait_for_response(struct smu_context *=
smu)
         uint32_t cur_value, i, timeout =3D adev->usec_timeout * 10;

         for (i =3D 0; i < timeout; i++) {
-               cur_value =3D RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_=
90);
+               cur_value =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
                 if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) !=3D 0)
                         return cur_value;

@@ -93,7 +93,7 @@ static int smu_cmn_wait_for_response(struct smu_context *=
smu)
         if (i =3D=3D timeout)
                 return -ETIME;

-       return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
+       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }

 int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
@@ -111,9 +111,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context=
 *smu,
                 return ret;
         }

-       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
-       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);

         return 0;
 }
--
2.17.1


--_000_MN2PR12MB44881D97DF9DB89FC4E92507F79D9MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Horace Chen &lt;horac=
e.chen@amd.com&gt;<br>
<b>Sent:</b> Friday, February 26, 2021 1:31 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; Tuiko=
v, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &lt;Christian.Koen=
ig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;;
 Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd=
.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.=
com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Xiaojie Yuan &lt;xi=
aojie.yuan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">sienna cichlid needs one vf mode which allows vf t=
o set and get<br>
clock status from guest vm. So now expose the required interface<br>
and allow some smu request on VF mode. Also since this asic blocked<br>
direct MMIO access, use KIQ to send SMU request under sriov vf.<br>
<br>
OD use same command as getting pp table which is not allowed for<br>
&nbsp;sienna cichlid, so remove OD feature under sriov vf.<br>
<br>
Signed-off-by: Horace Chen &lt;horace.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 ++<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 10 ++++++----<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp; | 10 +++++-=
----<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 12 ++++++------<br>
&nbsp;5 files changed, 20 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index f0f7ed42ee7f..dfbf2f2db0de 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2043,6 +2043,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pp_feature =3D=
 amdgpu_pp_feature_mask;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
|| sched_policy =3D=3D KFD_SCHED_POLICY_NO_HWS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pm.pp_feature &amp;=3D ~PP_OVERDRIVE_MASK;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;num_ip_blocks; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_block_mask &amp; (1 &lt;&lt; i)) =3D=
=3D 0) {<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index b770dd634ab6..1866cbaf70c3 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2167,7 +2167,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *=
dev,<br>
&nbsp;<br>
&nbsp;static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(powe=
r_dpm_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_force=
_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BAS=
IC),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_force=
_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BAS=
IC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_n=
um_states,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_c=
ur_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_f=
orce_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index d143ef1b460b..7033d52eb4d0 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -612,10 +612,12 @@ static int smu_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_default_od_settings(s=
mu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to setup default OD settings!=
\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;od_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_set_default_od_settings(smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Failed to setup default OD settings!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_populate_umd_s=
tate_clk(smu);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index af73e1430af5..441effc23625 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -89,17 +89,17 @@ static struct cmn2asic_msg_mapping sienna_cichlid_messa=
ge_map[SMU_MSG_MAX_COUNT]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetEnabledSmuFeatu=
resHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetRunningSmuFeaturesHigh,=
&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetWorkloadMask,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PPSMC_MSG_SetWorkloadMask,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetPptLimit,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetPptLimit,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetDriverDramAddrHigh,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetDriverDramAddr=
High,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetDriverDramAddrLow,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetDriverDra=
mAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetDriverDramAddrHigh,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetDriverDramAddr=
High,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetDriverDramAddrLow,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetDriverDra=
mAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetToolsDramAddrHi=
gh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_S=
etToolsDramAddrHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetToolsDramAddrLo=
w,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_=
MSG_SetToolsDramAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0)=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TransferTableSmu2Dram,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TransferTableSmu2=
Dram,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TransferTableSmu2Dram,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TransferTableSmu2=
Dram,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TransferTableDram2=
Smu,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Transf=
erTableDram2Smu,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(UseDefaultPPTable,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PPSMC_MSG_UseDefaultPPTable,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(RunDcBtc,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_RunDcBtc,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(EnterBaco,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_EnterBaco,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMinByFreq,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP=
SMC_MSG_SetSoftMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMaxByFreq,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP=
SMC_MSG_SetSoftMaxByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMinByFreq,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP=
SMC_MSG_SetSoftMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMaxByFreq,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP=
SMC_MSG_SetSoftMaxByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetHardMinByFreq,&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_SetHardMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetHardMaxByFreq,&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_SetHardMaxByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetMinDpmFreq,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetMinDpmFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index bcedd4d92e35..d955dc4c6998 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -73,7 +73,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *arg =3D RREG32_SOC15_NO_KIQ(MP1, 0, =
mmMP1_SMN_C2PMSG_82);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *arg =3D RREG32_SOC15(MP1, 0, mmMP1_S=
MN_C2PMSG_82);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int smu_cmn_wait_for_response(struct smu_context *smu)<br>
@@ -82,7 +82,7 @@ static int smu_cmn_wait_for_response(struct smu_context *=
smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value, i, tim=
eout =3D adev-&gt;usec_timeout * 10;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; timeo=
ut; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cur_value =3D RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cur_value =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((cur_value &amp; MP1_C2PMSG_90__CONTENT_MASK) !=
=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n cur_value;<br>
&nbsp;<br>
@@ -93,7 +93,7 @@ static int smu_cmn_wait_for_response(struct smu_context *=
smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D timeout)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ETIME;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15_NO_KIQ(MP1, 0, mm=
MP1_SMN_C2PMSG_90);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(MP1, 0, mmMP1_SMN=
_C2PMSG_90);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_cmn_send_msg_without_waiting(struct smu_context *smu,<br>
@@ -111,9 +111,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN=
_C2PMSG_90, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN=
_C2PMSG_82, param);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN=
_C2PMSG_66, msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG=
_90, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG=
_82, param);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG=
_66, msg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44881D97DF9DB89FC4E92507F79D9MN2PR12MB4488namp_--

--===============0020437517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0020437517==--
