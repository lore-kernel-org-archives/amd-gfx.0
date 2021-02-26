Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F473C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AC26146B
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AC26146B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D0A86E8E3;
	Fri, 26 Feb 2021 04:40:39 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760054.outbound.protection.outlook.com [40.107.76.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7CF6E8E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 04:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgzsjjE53Q5AAUQEVQOliZV5G4U/ushGBYSUO/GWdRjpiUyhIuG/kyRP9lgPTuswOsRDRlkDbzhs6iK9xMUa9tMaI3UDwyUNZxIjeUTa9C8r327NMp6p5u3iORqBFndAA/rictX+gqfS98KOmR41vrtXwdjKAj4U9VLBxjM8btG/yGEb40FRlDMRAHNBNBbUhIK6oVhk10SNYR3gw9ryf2wpvv53TuwPjJyXEaPGK6OHnb0NH+aN6J1zO29w3b1PQ8LF/0kEIsOflxG6nrTFFTIVmt7RLsGbEYPXwPjB5a2wxgP+daaMabwH7YcrD6chDLSaonhniY8scLhV6AqAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcHWA0uwuexRkw4aryXZEesw0r++/0HUlUmnkChV8F4=;
 b=ZRYnX925CEJ7DTRG0+XZJRtuugQmnJ1V85OlM1QdFlXVPs3XCElv3jG0wnmCY93NenIQ3EoTMakqm9/1Dn5bS6kxk5vrZH07SlzBLKfoWpTprV0ggHN8ZI0Ya6CtFij8ffGsubeBu0YQtNymi/zuZsBLw1QqingeXuP39JOoMCgLmkZVaCbjtIPVinQdiB1OOt/y9L4oBO6UaoJHrKdG9fhBCqqXrPTyRWEWbDwxEcbpR2jvJMi/YHywcGNn7PvPB2M4pbXO1mPvNJes8hYGzqJ9xmJxkk7OCDEw6yLCybTXt0Wvk/g6YxVXhI/eFj0ogH+JHSebYl0tpXzqzYWA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcHWA0uwuexRkw4aryXZEesw0r++/0HUlUmnkChV8F4=;
 b=F2XLtkqXEBt8dQFVf5i5erak0wRwbcI1UzyIHu+e9m9RR+urTvJM4lYZbDW381dM85qlUsnPeMEn/eogqCFvKqK3VBCZRSpB+ZV8paQfGunB5dCimyD3JuWMdcQTVh0KOyfM7q2FQrtk4T6iDxT/m8QrIZnT3BNFjFVz+uPlhRA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32; Fri, 26 Feb 2021 04:40:34 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Fri, 26 Feb 2021
 04:40:34 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable one vf mode on navi21 vf
Thread-Topic: [PATCH] drm/amdgpu: enable one vf mode on navi21 vf
Thread-Index: AQHXC25tEsCYPipMvEmpBBKNZR8Et6pp2+rA
Date: Fri, 26 Feb 2021 04:40:33 +0000
Message-ID: <DM6PR12MB2619ADEE4280CAF1EDB37E1DE49D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210225120444.27948-1-horace.chen@amd.com>
In-Reply-To: <20210225120444.27948-1-horace.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-26T04:40:30Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d1079747-efa8-4c2c-ada4-5ff131c78923;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f8fcd3f-b675-48f3-173c-08d8da10a7cb
x-ms-traffictypediagnostic: DM5PR12MB1708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17083B8549E3A181C478563AE49D9@DM5PR12MB1708.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCXs5RHmm3S5lmNf53QwtfjjLaGV/9deqYdNImF0ELgJSzGbyABtRnQqctIohRRB30EL8X+w09QR54LaQfe2QThVB3thbpQCHzwNhbjtx0T6FIs658518nMRp/X1DKA0tplb/shqcAx5Ugb4k4tiVA3lvsHhJQhpnQNK7bphS3kIyXrZL/VI8Nr9XBzmX656qTGukIjQCo6p2KM7N9/jXUeTcwL5zqQl7+c5qmCXuen9+ySr4gLinCUVTidYRV4qZTrlBPiFTi7sbDPd3YO3inc4w1IQNysAg6BWQ+OaUORQX5H1uxKLLXdAhicWAZ7hPs0Kr7Xt6dfoAZNBvqylsVVBXwfFtPSIU36cfJw/fhV/EH0Bzo87+W75yuxMx0jofDwsShi/iDyizRO9yaa6PiJSeJqNgS3ebRAVoDKc0bsz+Tg0S2ojUyAnMIffgA3vHPMKGZi3/4+ixA9vq0XUTHFeahEZknMXm7kokGnDnE+l6TSEwTypKPBJTRpSHnkXE2F3BKPjigQzS2SHXTJ4ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(4326008)(26005)(66556008)(64756008)(76116006)(53546011)(71200400001)(110136005)(8676002)(8936002)(2906002)(52536014)(86362001)(55016002)(6506007)(33656002)(5660300002)(186003)(7696005)(66946007)(83380400001)(478600001)(9686003)(316002)(54906003)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hYqUavFB0RazTGbXv4C7tCE5mdr4rgEIC51WLQHXuKZ11ouPBmAJmAbCzhsu?=
 =?us-ascii?Q?JHAhRmvSLtRN5DbW/Sea9oJInDB0cu5yYjod+WlCm2WTj4COj5zctNc9C+Ob?=
 =?us-ascii?Q?5F5Fp2wp9N0WuoeMUtv2Nl29lsbBJ6hP6qJGxBUl3AAD4r0qf5HWUHo0Gkzn?=
 =?us-ascii?Q?lk6N+n90WXsYKtaDepi3ImRdNstOghN67gUrkS2oG07MKXZ24nBwfP2ROZy2?=
 =?us-ascii?Q?i6LHQw4d63Oi70J7FeXSHqUqm/y+zsVDAzucoDOWWlFZASsNxW3chYjLDAex?=
 =?us-ascii?Q?NEk/HLMzLXd40eZWbMrRYPehZ1OasAdHaiKUQtUbRlIDNGz22HqjkvIoIZni?=
 =?us-ascii?Q?JB5RGpKHNvnV5p53sDfx3R/b42Ux60RxUv2TCND1x3orrJPDVk40sGjZy/1v?=
 =?us-ascii?Q?Is5o0ZQ9vYnwzmkhKm5+1vEs/bloYqbJgUcz1O2BVWOKo9lSqO8XABLkG/Mm?=
 =?us-ascii?Q?dIx6q4DRL3Vz+B1YR3lY3L1e4Z/B1N40vkVsXIEPr6qqG6yckmNzACsG2lLp?=
 =?us-ascii?Q?/TpH2FdbmmLbcu8HjzTmhybqd+EfyvxKUAhvAU87GUSU41d2b/3YEnGvJL07?=
 =?us-ascii?Q?BYBF8VyzBFJA6wnRcldxSGNBivei7dhqlYveImCy2+v6k39/cQML8SshLJ7Q?=
 =?us-ascii?Q?ZMFPM49Tuv988fiNisseyJIAakUljBuNexyL22U7h7TSURVJ9VdibEedupMM?=
 =?us-ascii?Q?ZDZu6dRuUX2EiZEuxtb5xjcB3b8qMoZGdcrBo0C3l7m5rhEopT3GG/gW/d+W?=
 =?us-ascii?Q?oEweO15OVbxUK84iOGqcbiTeO3zCd+WecnyphWxDtpqkZ+Gpof/fsrabywjR?=
 =?us-ascii?Q?TkY1ouyYhEw9RlFf63Iezk7nkvffgHNM9qRpZ3zMrOjqkSgs1lfXRyOIfuOG?=
 =?us-ascii?Q?G77C8fBSKIqo1wGBr6QH6yCPQPsTgTFWeVZ8loCAFLlcvEqtpjbiIDwhp27B?=
 =?us-ascii?Q?a0NAXkUHN5awSWsRKevEGKPXTZv7+I7yVeuo8gppb8VoQr+2mMNl3zYJ6e6m?=
 =?us-ascii?Q?v2TsQHFhHe7ifoILjInBdqVFU+cko2M8x4NhsOtY5FqADTXMwOlSNq3QWXsI?=
 =?us-ascii?Q?yMUtKqiWGBC7nBGxmHXMst9/3adTS4QzhY8KJIAe5WTWrtsjLSNjGuWPYSAN?=
 =?us-ascii?Q?vKUpdGQGg21B+TurmDQvPEdVnr9U1vtXrYnh5nBKmI+xnKIog457tXwcmebO?=
 =?us-ascii?Q?Y3FficpD0QE35BlX86yd4x/qNXkeXx4rVp4GA4kwGviubJic+Wh+501V93eM?=
 =?us-ascii?Q?aoYaSJfTO86bD4CYuoK8ilrQmDw4JV80/hEpUBVmtLIdXcW85+YslRO5Pes4?=
 =?us-ascii?Q?YhcXN9frYPvRpA2riDPvL//O?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8fcd3f-b675-48f3-173c-08d8da10a7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:40:34.0183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4Y1EvzSIY0VPn0R9DykVSayV1KarDyy9SBHhzro/O6U2/lxHkyr0GLTvi6Fw0Va
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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
 Jack" <Jack.Xiao@amd.com>, "Xu, 
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Horace Chen <horace.chen@amd.com> 
Sent: Thursday, February 25, 2021 8:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: enable one vf mode on navi21 vf

navi21 vf needs one vf mode which allows vf to set and get
clock status from guest vm. So now expose the required interface
and allow some smu request on VF mode. Also since navi21 blocked
direct MMIO access, use KIQ to send SMU request under sriov vf.

OD use same command as getting pp table which is not allowed for
 navi21, so remove OD feature under sriov vf.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 10 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c               | 12 ++++++------
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f0f7ed42ee7f..dfbf2f2db0de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2043,6 +2043,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
+		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b770dd634ab6..1866cbaf70c3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2167,7 +2167,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d143ef1b460b..7033d52eb4d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -612,10 +612,12 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	ret = smu_set_default_od_settings(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to setup default OD settings!\n");
-		return ret;
+	if (smu->od_enabled) {
+		ret = smu_set_default_od_settings(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to setup default OD settings!\n");
+			return ret;
+		}
 	}
 
 	ret = smu_populate_umd_state_clk(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index af73e1430af5..441effc23625 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -89,17 +89,17 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetRunningSmuFeaturesHigh,   1),
 	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,             1),
 	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,                 0),
-	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       0),
-	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        0),
+	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       1),
+	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        1),
 	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh,        0),
 	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow,         0),
-	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       0),
+	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       1),
 	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,       0),
 	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           0),
 	MSG_MAP(RunDcBtc,			PPSMC_MSG_RunDcBtc,                    0),
 	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   0),
-	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            0),
-	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            0),
+	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            1),
+	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            1),
 	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            1),
 	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,            0),
 	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq,               1),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index bcedd4d92e35..d955dc4c6998 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -73,7 +73,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	*arg = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 }
 
 static int smu_cmn_wait_for_response(struct smu_context *smu)
@@ -82,7 +82,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
 	uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
 
 	for (i = 0; i < timeout; i++) {
-		cur_value = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
+		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
 			return cur_value;
 
@@ -93,7 +93,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
 	if (i == timeout)
 		return -ETIME;
 
-	return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
 
 int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
@@ -111,9 +111,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 		return ret;
 	}
 
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
+	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
+	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
 
 	return 0;
 }
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
