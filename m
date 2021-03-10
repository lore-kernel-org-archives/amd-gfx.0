Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741AEC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 08:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02D264FE3
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 08:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02D264FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E816E9D5;
	Wed, 10 Mar 2021 08:25:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1AC16E9D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 08:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyznLI+d+JvJfXvrZb8l4A82b6h+RsrA9+R7H+nkjOaYzncL9HjfyX6vlrjxrW8NjQsqi9d+U1A/ieo2+SV8m7MOnbYSwX0QaI8S1ec8pMK+tzo3GS+e+CS1e5BuV9DhFM8xXmavTd3ZGlEbh5HmIdm/n3yypquvhUtlSretn9ZRiFDGksbdzSXe2qPS2+CsoKDoXT1Mpa0zLh1qgLXAn8h6Bi31neYmsWTsW2retPGATIh4hQLuanCW5XmIjrjHVwgm3DQ354ydk8DoHcqcMBF/Yl0dcg4qeq2vSbxBx+B95FP68AO605kSpMehjja+oCpmlsz0Qjb4reupb6MMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfYCTalsOa+RsKLJnvpVABOU/uFYkCevEm/kwK5AqmY=;
 b=foXdvTiFp3CEzRgXJEvZof3EDafVrryolY3XJSLunsjPbFJwlqPDQMmQ5e+cWmN93um0SGX5llEbNSE0CAdEzNUi+JIwig6zSBfeUW6BAzI/aITUc2Atm1zI/NlbrxFO37pMxDMMsX672VqB5VF2PqxvbdgJaur0FQZ3V77t7w1pAVACZy4PTSzdfr81nOwfmY9d9PYTb/sJCqEtiZMM1lEf6RUvSEtLu7FJXGP4vMqT8oShDTGuUchVQYKvstx/W9ZtPfAP6w0UnZRDj4jcE4i+X3+rPkMaxBe3KQ4faroc5sqlmWLb/fGqHAKYy8PkRIzhEqLSG0wxH/LO4mTDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfYCTalsOa+RsKLJnvpVABOU/uFYkCevEm/kwK5AqmY=;
 b=BQS7OTJnknkYDU4EyTCOIdMOMT1PYXF3DNssm2Rur24XCXNTELuig1aevdvgYvZfCM0tSiYSq6icpfZjj5mRIwo/mlz+scv5Zwm/WSYRkPTi1BNs3q001iF9nqh5zI2+Ca59+NtdHhkTsJ7GQYIIAvQ1MpbxN1gl4OxB0UOeR+E=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 08:25:11 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 08:25:11 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query
Thread-Topic: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy
 query
Thread-Index: AQHXFWOO4QJhOQN0mUSNO/5BatnUk6p84s6w
Date: Wed, 10 Mar 2021 08:25:11 +0000
Message-ID: <MN2PR12MB45498613B920ADB224FF308997919@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210310041150.289806-1-alexander.deucher@amd.com>
In-Reply-To: <20210310041150.289806-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T08:25:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=13ce3a51-abb2-45f5-b61a-e94e24aea62b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a88350a-2e72-4d23-a17c-08d8e39e05dc
x-ms-traffictypediagnostic: MN2PR12MB4254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4254A5337435EA14EBEE8DD897919@MN2PR12MB4254.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ye4iV7wATMErACFoJ7q4nLhiJ4y9EHW6Szbl3rCAGSUqjqmalnbI1RH7iRq8h+zAU30w5ydn8nKeGhf8/7FzHO14YSueGpyVS8GoeY5wlgnLRd4/d1PgWZM/Y2gLR0uC61WeBUF8lydfECY05mZ/q/a9mwskYRtc1oBt3kDETS49aJXqAmBwKGFNHExaE+us/xpKL0cAoa4IWbtlGEuQMhLQH7oThBm2l9B8kl5R0z5FY7zW1o6F+qRHFwEk+tdDuAM4tSw4gx5vODQLBEQ9XQnWmQtZaKCEKfrac0q+9qYbZ4EiEoe0Je6lUebB9ZN2WBIxdxw8UoY0aSw3tOqm6rCQFa/qlPTIbIhO2vS58gyJ8PeLjy8XMXLN20mRuZB5O/DApEqz5+Qgt1ulr9QKLPnWrcjFKM4N3HmCdTyqEB/Tfin2imEhG6yhst98p/gg/q7yGpctGega+78+X4SY0UiUrtk1qOA0ft9N8zPJ2RyPzFABKkk3rO1bwyIGeLA9rou2HzbNGORn/ACqGc5VIz8w0Wa09RvMzzrq5yFgf/LBa0A6lbGbLQDTAtXctM6Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(55016002)(316002)(45080400002)(9686003)(8936002)(26005)(110136005)(86362001)(4326008)(186003)(64756008)(66556008)(66446008)(66946007)(52536014)(66476007)(6506007)(76116006)(5660300002)(2906002)(33656002)(53546011)(478600001)(8676002)(7696005)(71200400001)(966005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NAgNPnzuuICWopUjAD74l/jgf/y3dueGhp2lEHJ91249YJPAvNHW2GwkXC2Q?=
 =?us-ascii?Q?+P2ZL1CQcGj4SqfCxhThCJ6ON7YRtWMvuwAc6/FccentpQTP1HeVGLVjS9qw?=
 =?us-ascii?Q?OdgZRdtFt3cSHBQVquhEpWxRvU6WEDFx9XBjm7BABSOED3l8kydVoKNl226s?=
 =?us-ascii?Q?BRxppOZYKG9Nbw5ghMKfMu8DOl7HGteeoR+uvE2PUum1DDsogvmfBQQbjOJr?=
 =?us-ascii?Q?+7yGwdQai2Lz0d8e9unRX/wA36L+67PMySoYuCAi/9g2a3X1CKz6f1COomDo?=
 =?us-ascii?Q?iDkqvs+78EfVWDcpxPpsR042FvMw+TgnVJbrZXb/RVpMEdRkU6xXrJcpDX6l?=
 =?us-ascii?Q?3Xv6H7abvsCxoUEHMbDN2UicojKZPFxX+s2DYp4xqq9kW0e5dhpBQcleQLqv?=
 =?us-ascii?Q?ovhjah8+A7dvEQ8BS4EBLTznBd+JNXdFvGw+Tx2NUnmPHfRL0BJYIYlEYXG/?=
 =?us-ascii?Q?RJjsIV5NGL0+kFwQFjiiHJu5fA7ZBYozu7cPE834NJe3Ncs5YG4UfC8Cg0A4?=
 =?us-ascii?Q?Od7dC+RSIIvam4D7EIzI+5GVIb/WDtA8PhJRoca0Z+JE1YHdo7a8ysf86lgt?=
 =?us-ascii?Q?KcVr8FP/GbYcc+T/fM2o1eg5dc9M+FPBfhn9C3V/D7m5+Xh+UPCU8rihIdPe?=
 =?us-ascii?Q?mLtwKiz+nfMwcX7oazwKQSMH4b+SxYUVtn12X6swuoJK6F+MKKXjRFEMjVAq?=
 =?us-ascii?Q?tizFVL883BuJGCJhma3MfnUzyqtVBcMtKrBIHVJGUyBoV931m2JQe0doyYXr?=
 =?us-ascii?Q?pDxnCclWzfdwXponD4tVGtk7wBU3Rl/y6Lm0zPswG1SpExCFRcvwIaOcjYM9?=
 =?us-ascii?Q?X9m9JIzr4p+WgERHuXCeeQrusv7iwyUM3Br0EEE7YdJhvxsoS6TsvdcrFVL4?=
 =?us-ascii?Q?+g5rJupInbQhQgiJT9r6Fx4UFm4M1lwRcvMVuiPSuVRVuw8TGBFKk5j64QiK?=
 =?us-ascii?Q?nF6MM3go21vuiGtFqkjUW3dVqwyYb4NmN95CGllFCKNKKYsDtlJIWjeqe2HC?=
 =?us-ascii?Q?9uoWUNYANu0J5nt+mWla8TUcgovlh2XeQx15GRtUhb2Rr7WBG6fxtEaNVmp3?=
 =?us-ascii?Q?Z18ryh1XTVhlGeFmQ97WIStooQhW06K9MdkGJZvrpjPmfvZHAnrMvZGcOMfN?=
 =?us-ascii?Q?w6w5DFihCLZT+Y8cz8NbIIPXPF0JM1Q9twB+bInAYjfXfKu416nx+8XHAo1N?=
 =?us-ascii?Q?DuLTj/vtk0tHTGSbxdIfaY+PaxaGbQy/rUzaCZTx17tKa2ylLVHFzmZ5u7wk?=
 =?us-ascii?Q?aeZpJaUp+Z2P5dvTgPzh0HoAzMeLVbnS/QJTjbZcy8Sn0SI2f7p3RcwqZs7/?=
 =?us-ascii?Q?cwsjKtc2LF4qxc8i9mh3TzFc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a88350a-2e72-4d23-a17c-08d8e39e05dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 08:25:11.3238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: In9oV2XSETn4vxzFoNKHG/Z5AWnYS6L+Gz5uV7I8YLKAvrNXaA7bSGwJ7ktmqfMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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

[AMD Public Use]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, March 10, 2021 9:42 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query

Was added in newer versions of the firmware.  Add support for it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h         |  1 +
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 30 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
index 4c7e08ba5fa4..171f12b82716 100644
--- a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
@@ -84,6 +84,7 @@
 #define PPSMC_MSG_PowerGateMmHub                0x35
 #define PPSMC_MSG_SetRccPfcPmeRestoreRegister   0x36
 #define PPSMC_MSG_GpuChangeState                0x37
+#define PPSMC_MSG_GetGfxBusy                    0x3D
 #define PPSMC_Message_Count                     0x42
 
 typedef uint16_t PPSMC_Result;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index c932b632ddd4..52fcdec738e9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1261,9 +1261,21 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			  void *value, int *size)
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
-	uint32_t sclk, mclk;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t sclk, mclk, activity_percent;
+	bool has_gfx_busy;
 	int ret = 0;
 
+	/* GetGfxBusy support was added on RV SMU FW 30.85.00 and PCO 4.30.59 */
+	if ((adev->apu_flags & AMD_APU_IS_PICASSO) &&
+	    (hwmgr->smu_version >= 0x41e3b))
+		has_gfx_busy = true;
+	else if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
+		 (hwmgr->smu_version >= 0x1e5500))
+		has_gfx_busy = true;
+	else
+		has_gfx_busy = false;
+
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &sclk); @@ -1284,6 +1296,22 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*(uint32_t *)value =  smu10_data->vcn_power_gated ? 0 : 1;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		if (has_gfx_busy) {
+			ret = smum_send_msg_to_smc(hwmgr,
+						   PPSMC_MSG_GetGfxBusy,
+						   &activity_percent);
+			if (!ret) {
+				activity_percent = activity_percent > 100 ? 100 : activity_percent;
+			} else {
+				activity_percent = 50;

<> Why this is assumed? Isn't this as good as not supported?

Thanks,
Lijo

+			}
+			*((uint32_t *)value) = activity_percent;
+			return 0;
+		} else {
+			return -EOPNOTSUPP;
+		}
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C4ae33de1e1cb46155eef08d8e37aaf58%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509463368911804%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2KX02OYjW4d7%2FFK3dOUz6kiBb8MUItOSOqoDEnu8Lrk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
