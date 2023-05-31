Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57978C7EE2E
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 13:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C334310E4BE;
	Wed, 31 May 2023 13:07:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA36610E4BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 13:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDQb9MMkEAXRHg81mG9JPddegwLrfwP/fLGp6hXtpJO8pLHTQSfr8VpRqc4J1S7kqK2HzYhvahUXR3nLS1ZwGXv9MIHrQgerg3LKi+FIjvo1TVp2guOoDMDadhjeFBFeViFPGQzhOl2NHWZpUP3r4AjjigE6W/+MkTcr0/9fCkpDBhg3Mfu5t5iJCWPzrkypxDwl8lyHOAiYcIZ8BzuhkluA213PPVyCAfeYEJUTWjjIc4kMJSxwjyHjK2FQvm2YHJIaIn+bESSmhYZMx2Boze+HomYXq7TfBtkyZSCyuo7dPI8MQW/7+I2YZm/9TojMSQCCE/s4L1yCstkcZQ12Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXCBij3mJQTZPaJ76+N24pCl6ySx2vEaS/mzrEjIt/s=;
 b=QDTtoQm44JbBeV3Vdzcvx3Bz7uPsX2bxd99F6/AIcHCEX2vbDwaWE5a5RFdjme9LARZg5y0RNih7HvvGlJFpgcYl+t7LserQqTLJ56P/1vxfKDvMWu8HNvnwlkF/sWv+pKeXqz7zOrTe0rcGkqYUOprsd2q7QeSPq2stMeZsMmXs7BfKrwCLdmAiDKhPESLNxpNyeoBSO/opA7NsvvibkSIuTgGjWAvEBIim60zRhvhB4+tY1HAt+jCm4fE5VI58WlJQROuEQjlUnb11aBmNxJptUBUZlmqMvzGksPWLTIePIzxdSAN1ZlhZ+GhORedZaRSSEloZUbZ8xGvmw4dDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXCBij3mJQTZPaJ76+N24pCl6ySx2vEaS/mzrEjIt/s=;
 b=QkyjeKozJxR1Eejj/ytKwwmyEGz/6eYiP0jJa+dqFFEYoqMZK1bKIw6+8iHuG9Vme6kYi1GC+f3se/6Zumt5AryVGqUZxBIIFF4PutDn1iH7Yuy8MlRTASyry0q1N9bzloljMbnxjKkpGWNHV5j7qzEEaw/fCCu2On4r64b9kOQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 13:07:17 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 13:07:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix up kdoc formatting in
 dcn32_resource_helpers.c
Thread-Topic: [PATCH v2] drm/amd/display: Fix up kdoc formatting in
 dcn32_resource_helpers.c
Thread-Index: AQHZk6FtrVtw7M3KL0yMW9ivqdhSI690WkJx
Date: Wed, 31 May 2023 13:07:16 +0000
Message-ID: <BL1PR12MB5144F7D14A9AFD28FEB3D580F7489@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230531092202.3352796-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230531092202.3352796-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-31T13:07:16.432Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB5040:EE_
x-ms-office365-filtering-correlation-id: e3c368ac-149c-412e-a9dc-08db61d7f5a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndtyhnO9zmlz8tGFH7bpcTiaNS+C4Q92W3XxSIH1HU4lzZcsQO5fX449Mdsx7x0o32ykZe9NfFlPfabev3y8y5K9/9FOF8R+hj16KPlaqb24AY7nNmE6ubajVXPL/HbQ0T5jeeLsa8RPd4HPBlqUZ49FuAXkfAW8lWRukAxPd8e2oABPMPcc04Ozl8xF/0PlgBKIqHcFs7htyU6bs2O06IvHioVpVt7u7Y6pUx/2WuPRKa3eWlGVHwmbkWAlHqkmHwCCabU/hptdx3Wkjx6ZATg3Ydn8uc8z4P7TjmoM9HzAtVB1smZb/giazxZ35nVWF+NqHhXapfIfvvEpDMkAHxUFdv2IHax6x3MSkOBr+Ab8xY8LGKRvrskg4URDNWAfHGBmIXvGiDI/dprwufzMTQkuJ1y3GZGC8BS/fpe23JkjNxfQ43Yp4Tv4sZuW9grmaBjJMThTnHSTcyDFUCxB5A9BB8pFuvpsjenL2XkT3DQDYgrTgSQzwTiTU5Ssoa9UvOx0a92v8VWa0wwFBN9mP1j/mhyth7RWyVUxmtA5itSpM174kmrti7e5lQsipJKw+cfZJSaHzLs6tO6huK1N+D1R4CAOfJaRvW+tKGP2V6yAHc4wf032OEjRdNjs/BCZxPx/UKyCZCWCIH4t27KceQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(186003)(38100700002)(41300700001)(83380400001)(19627405001)(9686003)(26005)(6506007)(53546011)(7696005)(478600001)(110136005)(71200400001)(4326008)(921005)(122000001)(76116006)(66446008)(64756008)(66476007)(66946007)(66556008)(91956017)(6636002)(55016003)(316002)(52536014)(8936002)(5660300002)(8676002)(2906002)(33656002)(38070700005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hn8FhJGSF9iWU/qemmwUz88wb/g1FX6xThjFqHQj1MrBrxHlyfh2Im+OVKea?=
 =?us-ascii?Q?+0v5SgJdph2prRxecKWm7oKCGSqyan79NO2kfSvO42zhjJ/jk4Xh2432QDXX?=
 =?us-ascii?Q?CTvp6QKc6rBVeV/xGC8SQBxOPuHdymRvHpSCWCrIS5rbnKwJS2yVIGnKBMzS?=
 =?us-ascii?Q?e9G+nLVfFbBLEgt74zwwyC/B9Jfw4z/z3iUVLFt+6/OzihLisaarOFwXobSC?=
 =?us-ascii?Q?LE8ClZ1zfBRJPT/AP97RI+KcJ6mgZaPIcLwZKoDqYG8xuXL/Itrk7HuhEUP8?=
 =?us-ascii?Q?Q+NdIoUDs5ddN3MEJvIYRrN/y2EpiXUYpj88WWEPEZO5Y9u5LsYbb3FAysx1?=
 =?us-ascii?Q?9+GmwGbGD5XL6JaKH2kPG1P42KX4ZP1zB/Az7E9zUVqUshSU5dXXaom0NZ2Z?=
 =?us-ascii?Q?Co7IYn8aJXAMvdF57ygKTwmBJVIvjFRHbrfNqhzAGn8tIZo11ktks0jt5LvE?=
 =?us-ascii?Q?gc6zopcIjpuDQXUMe8XH+djAFuSPBAInypzjIoOY3lG13jKYE+WyfcCEU5zE?=
 =?us-ascii?Q?xJw5++g949BGcvOfAC5i3Jt++kYmqFSztgGzudNMJOdRpgprKUpS1TOJKJ2e?=
 =?us-ascii?Q?VXeKauXie7vccmp3ztpEWNQ3qg+mu+Kk6PNWkG/x0lPaxUdzFXXjRxwHzNaj?=
 =?us-ascii?Q?G0YDz1eR/OXaiw02hXdhnyWcFf9AuhEAuWcAASCzRffORSHZ3CgtlwL6AUtH?=
 =?us-ascii?Q?KRXjq7AxOkDb6sNYkVaCnZ8dZ0OEl9lH2EzhDkuaPTnhNujylPt46faqDKUq?=
 =?us-ascii?Q?FdeZkt1gJHcxSMQwXk8lQ4HI4ltrYTeEI/nPTUI0b8VguOtIaN+LhD45AYL9?=
 =?us-ascii?Q?owapV9iXsA/wE7u0Tmm0jDoYogYyKkeSGy2e00LbR0GVsbl/c/33/EQeHn7X?=
 =?us-ascii?Q?HP80Py3wKWyP5PuQule0CmI1SRKeEVgeZNsUq5uz8lxXRaqPv4wt3nCy6EHi?=
 =?us-ascii?Q?fC9q+HnwrcuEe75L44PqGRYCQgd1/0f8iQkedzyUIkxFBDXlIXD/WHQEhZaR?=
 =?us-ascii?Q?m0dD2i3XoaWtTa01AWhrkUfbBvJQzxmqjpgO8ROgZhbhzGkEWGQn8izGf32v?=
 =?us-ascii?Q?v8THBhQt/ZEx+D2NAqFZIaFGECmXXXdvYe2rM6Ia7hO0PRT5rg47SB76pikv?=
 =?us-ascii?Q?Fv2THWbN1OT8c1YxJuhgyDLMbILpVOFkllHq1G5yciqDaizXpNr1+mAqj6/J?=
 =?us-ascii?Q?0ibL2oM2j5K5GOBkYeLmWqE8Ll3ciFkksTBGmIPwRb9mTMDIugzHySmGwGOe?=
 =?us-ascii?Q?ef1H+a5yHM5paBP/ticcUK1n6F8UlomjtguL2WzWWyiCV4AnvQTKTlO5XF3W?=
 =?us-ascii?Q?5Jxbsj74cn/pWHea7Q21C1D3mZpYNkV/r7CXStxY/FV2DxaEIz21CC0fx1Zq?=
 =?us-ascii?Q?J/jaEpLccwiSM3Bddd8OZs2egfJKLcgzz46CWEopexyPd7yEPx0GvrD7rHH4?=
 =?us-ascii?Q?Ygbjprv5ivR8d0kVtTSEFE3S/m//fqQ7wlrModtR7bjbQpiznaW46r/saA5m?=
 =?us-ascii?Q?QqqBrY+cbrgFQAsvUKNPqplxp8cRp0yJJD0Ogz7pikomGCPhByNkwZHIpYC3?=
 =?us-ascii?Q?Tm0gzj79k9FRakEMd5k=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F7D14A9AFD28FEB3D580F7489BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c368ac-149c-412e-a9dc-08db61d7f5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 13:07:16.9614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BpPojlqFiixjYhjJ4ZeGMJctL/dcyRbgQFEbbC8r0mVxczTXX9EfUnuFHOOPN0T3SWZQQu84LQ4BgBBjGCRvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5040
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144F7D14A9AFD28FEB3D580F7489BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Srinivas=
an Shanmugam <srinivasan.shanmugam@amd.com>
Sent: Wednesday, May 31, 2023 5:22 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Mahfooz, Hamza <Hamza.Mah=
fooz@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Wentland, Harr=
y <Harry.Wentland@amd.com>
Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; amd-gfx@lists.fre=
edesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: Fix up kdoc formatting in dcn32_resour=
ce_helpers.c

Fixes the following W=3D1 kernel build warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:97:=
 warning: Cannot understand  * ********************************************=
******************************
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:264=
: warning: Cannot understand  * *******************************************=
******************************
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:435=
: warning: Cannot understand  * *******************************************=
******************************
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:475=
: warning: Cannot understand  * *******************************************=
******************************

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:599=
:
warning: Function parameter or member 'dc' not described in
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:599=
:
warning: Function parameter or member 'context' not described in
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:587=
:
warning: Function parameter or member 'dc' not described in
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:587=
:
warning: Function parameter or member 'context' not described in
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - Fixes added for line no. 587 also.

 .../display/dc/dcn32/dcn32_resource_helpers.c | 57 ++++++++-----------
 1 file changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c =
b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index a8082580df92..1d13fd797212 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -94,18 +94,15 @@ uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(
 }

 /**
- * ***********************************************************************=
*********************
- * dcn32_helper_calculate_num_ways_for_subvp: Calculate number of ways nee=
ded for SubVP
+ * dcn32_helper_calculate_num_ways_for_subvp(): Calculate number of ways n=
eeded for SubVP
  *
  * Gets total allocation required for the phantom viewport calculated by D=
ML in bytes and
  * converts to number of cache ways.
  *
- * @param [in] dc: current dc state
- * @param [in] context: new dc state
+ * @dc: current dc state
+ * @context: new dc state
  *
- * @return: number of ways required for SubVP
- *
- * ***********************************************************************=
*********************
+ * Return: number of ways required for SubVP
  */
 uint32_t dcn32_helper_calculate_num_ways_for_subvp(
                 struct dc *dc,
@@ -261,8 +258,7 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
 #define DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER 7

 /**
- * ***********************************************************************=
********************
- * dcn32_determine_det_override: Determine DET allocation for each pipe
+ * dcn32_determine_det_override(): Determine DET allocation for each pipe
  *
  * This function determines how much DET to allocate for each pipe. The to=
tal number of
  * DET segments will be split equally among each of the streams, and after=
 that the DET
@@ -290,13 +286,11 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  * 3. Assign smaller DET size for lower pixel display and higher DET size =
for
  *    higher pixel display
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
- * @param [in]: pipes: Array of DML pipes
- *
- * @return: void
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @pipes: Array of DML pipes
  *
- * ***********************************************************************=
********************
+ * Return: void
  */
 void dcn32_determine_det_override(struct dc *dc,
                 struct dc_state *context,
@@ -432,8 +426,7 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc=
_state *context,
 }

 /**
- * ***********************************************************************=
********************
- * dcn32_save_mall_state: Save MALL (SubVP) state for fast validation case=
s
+ * dcn32_save_mall_state(): Save MALL (SubVP) state for fast validation ca=
ses
  *
  * This function saves the MALL (SubVP) case for fast validation cases. Fo=
r fast validation,
  * there are situations where a shallow copy of the dc->current_state is c=
reated for the
@@ -446,13 +439,11 @@ void dcn32_set_det_allocations(struct dc *dc, struct =
dc_state *context,
  * NOTE: This function ONLY works if the streams are not moved to a differ=
ent pipe in the
  *       validation. We don't expect this to happen in fast_validation=3D1=
 cases.
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
- * @param [out]: temp_config: struct used to cache the existing MALL state
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @temp_config: struct used to cache the existing MALL state
  *
- * @return: void
- *
- * ***********************************************************************=
********************
+ * Return: void
  */
 void dcn32_save_mall_state(struct dc *dc,
                 struct dc_state *context,
@@ -472,18 +463,15 @@ void dcn32_save_mall_state(struct dc *dc,
 }

 /**
- * ***********************************************************************=
********************
- * dcn32_restore_mall_state: Restore MALL (SubVP) state for fast validatio=
n cases
+ * dcn32_restore_mall_state(): Restore MALL (SubVP) state for fast validat=
ion cases
  *
  * Restore the MALL state based on the previously saved state from dcn32_s=
ave_mall_state
  *
- * @param [in]: dc: Current DC state
- * @param [in/out]: context: New DC state to be programmed, restore MALL s=
tate into here
- * @param [in]: temp_config: struct that has the cached MALL state
- *
- * @return: void
+ * @dc: Current DC state
+ * @context: New DC state to be programmed, restore MALL state into here
+ * @temp_config: struct that has the cached MALL state
  *
- * ***********************************************************************=
********************
+ * Return: void
  */
 void dcn32_restore_mall_state(struct dc *dc,
                 struct dc_state *context,
@@ -588,10 +576,11 @@ static int get_refresh_rate(struct dc_stream_state *f=
po_candidate_stream)
 }

 /**
- * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch - Determine=
s if config can support FPO
+ * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch() - Determi=
nes if config can
+ *                                                                 support=
 FPO
  *
- * @param [in]: dc - current dc state
- * @param [in]: context - new dc state
+ * @dc: current dc state
+ * @context: new dc state
  *
  * Return: Pointer to FPO stream candidate if config can support FPO, othe=
rwise NULL
  */
--
2.25.1


--_000_BL1PR12MB5144F7D14A9AFD28FEB3D580F7489BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Srinivasan Shanmugam &lt;srin=
ivasan.shanmugam@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 31, 2023 5:22 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Mahfooz, Ham=
za &lt;Hamza.Mahfooz@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@am=
d.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Cc:</b> SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; amd-=
gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/display: Fix up kdoc formatting in dcn32=
_resource_helpers.c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes the following W=3D1 kernel build warning:<br=
>
<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:97:=
 warning: Cannot understand&nbsp; * ***************************************=
***********************************<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:264=
: warning: Cannot understand&nbsp; * **************************************=
***********************************<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:435=
: warning: Cannot understand&nbsp; * **************************************=
***********************************<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:475=
: warning: Cannot understand&nbsp; * **************************************=
***********************************<br>
<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:599=
:<br>
warning: Function parameter or member 'dc' not described in<br>
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:599=
:<br>
warning: Function parameter or member 'context' not described in<br>
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'<br>
<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:587=
:<br>
warning: Function parameter or member 'dc' not described in<br>
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:587=
:<br>
warning: Function parameter or member 'context' not described in<br>
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'<br>
<br>
Cc: Hamza Mahfooz &lt;hamza.mahfooz@amd.com&gt;<br>
Cc: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
<br>
v2: <br>
&nbsp;- Fixes added for line no. 587 also.<br>
<br>
&nbsp;.../display/dc/dcn32/dcn32_resource_helpers.c | 57 ++++++++----------=
-<br>
&nbsp;1 file changed, 23 insertions(+), 34 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c =
b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c<br>
index a8082580df92..1d13fd797212 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c<br>
@@ -94,18 +94,15 @@ uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(<=
br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * ***********************************************************************=
*********************<br>
- * dcn32_helper_calculate_num_ways_for_subvp: Calculate number of ways nee=
ded for SubVP<br>
+ * dcn32_helper_calculate_num_ways_for_subvp(): Calculate number of ways n=
eeded for SubVP<br>
&nbsp; *<br>
&nbsp; * Gets total allocation required for the phantom viewport calculated=
 by DML in bytes and<br>
&nbsp; * converts to number of cache ways.<br>
&nbsp; *<br>
- * @param [in] dc: current dc state<br>
- * @param [in] context: new dc state<br>
+ * @dc: current dc state<br>
+ * @context: new dc state<br>
&nbsp; *<br>
- * @return: number of ways required for SubVP<br>
- *<br>
- * ***********************************************************************=
*********************<br>
+ * Return: number of ways required for SubVP<br>
&nbsp; */<br>
&nbsp;uint32_t dcn32_helper_calculate_num_ways_for_subvp(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc *dc,<br>
@@ -261,8 +258,7 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)<br>
&nbsp;#define DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER 7<br>
&nbsp;<br>
&nbsp;/**<br>
- * ***********************************************************************=
********************<br>
- * dcn32_determine_det_override: Determine DET allocation for each pipe<br=
>
+ * dcn32_determine_det_override(): Determine DET allocation for each pipe<=
br>
&nbsp; *<br>
&nbsp; * This function determines how much DET to allocate for each pipe. T=
he total number of<br>
&nbsp; * DET segments will be split equally among each of the streams, and =
after that the DET<br>
@@ -290,13 +286,11 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)<br>
&nbsp; * 3. Assign smaller DET size for lower pixel display and higher DET =
size for<br>
&nbsp; *&nbsp;&nbsp;&nbsp; higher pixel display<br>
&nbsp; *<br>
- * @param [in]: dc: Current DC state<br>
- * @param [in]: context: New DC state to be programmed<br>
- * @param [in]: pipes: Array of DML pipes<br>
- *<br>
- * @return: void<br>
+ * @dc: Current DC state<br>
+ * @context: New DC state to be programmed<br>
+ * @pipes: Array of DML pipes<br>
&nbsp; *<br>
- * ***********************************************************************=
********************<br>
+ * Return: void<br>
&nbsp; */<br>
&nbsp;void dcn32_determine_det_override(struct dc *dc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_state *context,<br>
@@ -432,8 +426,7 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc=
_state *context,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * ***********************************************************************=
********************<br>
- * dcn32_save_mall_state: Save MALL (SubVP) state for fast validation case=
s<br>
+ * dcn32_save_mall_state(): Save MALL (SubVP) state for fast validation ca=
ses<br>
&nbsp; *<br>
&nbsp; * This function saves the MALL (SubVP) case for fast validation case=
s. For fast validation,<br>
&nbsp; * there are situations where a shallow copy of the dc-&gt;current_st=
ate is created for the<br>
@@ -446,13 +439,11 @@ void dcn32_set_det_allocations(struct dc *dc, struct =
dc_state *context,<br>
&nbsp; * NOTE: This function ONLY works if the streams are not moved to a d=
ifferent pipe in the<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; validation. We don't expect th=
is to happen in fast_validation=3D1 cases.<br>
&nbsp; *<br>
- * @param [in]: dc: Current DC state<br>
- * @param [in]: context: New DC state to be programmed<br>
- * @param [out]: temp_config: struct used to cache the existing MALL state=
<br>
+ * @dc: Current DC state<br>
+ * @context: New DC state to be programmed<br>
+ * @temp_config: struct used to cache the existing MALL state<br>
&nbsp; *<br>
- * @return: void<br>
- *<br>
- * ***********************************************************************=
********************<br>
+ * Return: void<br>
&nbsp; */<br>
&nbsp;void dcn32_save_mall_state(struct dc *dc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_state *context,<br>
@@ -472,18 +463,15 @@ void dcn32_save_mall_state(struct dc *dc,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * ***********************************************************************=
********************<br>
- * dcn32_restore_mall_state: Restore MALL (SubVP) state for fast validatio=
n cases<br>
+ * dcn32_restore_mall_state(): Restore MALL (SubVP) state for fast validat=
ion cases<br>
&nbsp; *<br>
&nbsp; * Restore the MALL state based on the previously saved state from dc=
n32_save_mall_state<br>
&nbsp; *<br>
- * @param [in]: dc: Current DC state<br>
- * @param [in/out]: context: New DC state to be programmed, restore MALL s=
tate into here<br>
- * @param [in]: temp_config: struct that has the cached MALL state<br>
- *<br>
- * @return: void<br>
+ * @dc: Current DC state<br>
+ * @context: New DC state to be programmed, restore MALL state into here<b=
r>
+ * @temp_config: struct that has the cached MALL state<br>
&nbsp; *<br>
- * ***********************************************************************=
********************<br>
+ * Return: void<br>
&nbsp; */<br>
&nbsp;void dcn32_restore_mall_state(struct dc *dc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_state *context,<br>
@@ -588,10 +576,11 @@ static int get_refresh_rate(struct dc_stream_state *f=
po_candidate_stream)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch - Determine=
s if config can support FPO<br>
+ * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch() - Determi=
nes if config can<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; support FPO<br>
&nbsp; *<br>
- * @param [in]: dc - current dc state<br>
- * @param [in]: context - new dc state<br>
+ * @dc: current dc state<br>
+ * @context: new dc state<br>
&nbsp; *<br>
&nbsp; * Return: Pointer to FPO stream candidate if config can support FPO,=
 otherwise NULL<br>
&nbsp; */<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F7D14A9AFD28FEB3D580F7489BL1PR12MB5144namp_--
