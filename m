Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7477C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 13:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F3B61370
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 13:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F3B61370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CAE6E886;
	Thu, 13 May 2021 13:35:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2C66E886
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 13:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNKEjcReDEwBnS0Ncb6A0cNQK7ENv5oTPBkUx3MGMA5RpklgqtD718e88YWFbnaE9qR2F341rL5XnvofMVbYJid/1xn0op2sGWxgXJXHjG8MNRa+Gc9yB/7T0TPjuZcVY/J/tVm0s1AETiw7hzeK+FZghBTvV+kwvKcZHGQMDBTP5a6pJdZT3r8WhW1mwaKSx7yqlW/g3HD4hkWGf7GRBduE0n6szIbPWWpAQc/2tZDEJaMLD8FpBLxqQQOChVcd8YkuF/vZipKv2obwsjI1S9K3Nel38GsDS4XxWW/u+I0F9vVwhSiWegcN/fAgGf7jt0bFjvp6YZ4lfFclIHfQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtwEkKoeVGwNp79yJjQvXxjp6Jvlo1Aziw+oIKaNm+w=;
 b=Y9RlOQzl/E40qBrDnxlRIKWpm5eoGHACbd1x5O/RBfNc4h+JQxbl00vOHZhvoIvu2/PNr8tB3m+uC55PTtjbzKhVs84mbghWBwaYFJWVQHyYvNxf+R/+50AupmCugDe82jnVIIK546wYdjDVdfvT+oXX+kAjSva6lMsovVcSYiFwTZhZZ0dlTTbp6dilfBCdQsDUexMP32JEzV12tmrjp3GnRAKUP0OIzPdpRMzOio5z7emNEQGHNmhz/Tva5UDP833SPWwjtwMb380OrYPE2RC6XABh82b1edJa/rVNYSyKDH+l+EeTMGw3EkmqPX7/S9P6vdKAAUtnEWKGGeVpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtwEkKoeVGwNp79yJjQvXxjp6Jvlo1Aziw+oIKaNm+w=;
 b=q9aun/vaN78VYM/9rPwVCHWV2s6yq4ALKdoJYZVY5zNgKXRpf0FJeIe4kov0Q2Lw7J0AxsgUfGLC/VfVtF5zwDj49+H/NFmxbS0/clszWvgbReI1ovBXiCYVPMK+FEgVba7/SCdSbLsasVYqJR3AW8fafZOI7rNyqq/AjkvftM0=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Thu, 13 May
 2021 13:34:59 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835%4]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 13:34:59 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on
 aldebaran
Thread-Topic: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on
 aldebaran
Thread-Index: AQHXR90LOP8kW1r9LEKw3exFksZ70qrhaOiA
Date: Thu, 13 May 2021 13:34:59 +0000
Message-ID: <CY4PR12MB1287B680C787B7C55C767136F1519@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <cb35e9cc-26cf-c9e7-b747-c24920d788d6@amd.com>
In-Reply-To: <cb35e9cc-26cf-c9e7-b747-c24920d788d6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-13T13:34:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1e342445-324a-4cb4-9a05-ac0efb380c05;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.229.235.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 268d8b9d-7113-428c-9858-08d91613e76e
x-ms-traffictypediagnostic: CY4PR1201MB0120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01207CACED6B0D7B52273D79F1519@CY4PR1201MB0120.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IxeC+MMKXWJgG6OS7+7Z8Fp4jwsRLoZWKTb1nm2aP1d0qrG1T/8CQC7lkG3+bu1HU5MsqXTKIbLxhaX9QmomKLyDIrbsj7VI82xIBmE1KgrLobGnRrgSQYQt9f/ryUa6DfV0oyMQXb+WMKM2qmzy4JDPnf/ob4Pm/IaTvomFpAoAwt6BxgXCxoFuMCfosCNhwz6YPRxlRl6MJnNmCwYaGaj0wvNg3KVQka8ZFgZk5pfC2aQdIm2aka6Q9sW/31IVpnqRIuWNs+wJ2xf8f+T42478M9SGuUlSB6oI9BRFfEfFyroBOtkKJn6SEtw8eZdi197yRvwyEWUpr7yqKuzx4X+ilwjkLg5WBKNFhRHk7xjNk7v35taYWV8tY9NXO5wRKLtZBn0JzfxvtGW7FetTZxrfNzhN6cKUVmLvRrMKjVcUFAsv4K0dSvPeN9aQ0XGJK7jdKBHRwmH7Enn6FakzkYtnyHYwXJudk78TznUYh5uoTiwHgGwHeCz6hEKJFWvse5IkIpgxDttJKQkPQ/uegFEY1Xae7XqygBX4S55czopZ53fx+NcLksc7HpZPfJ4S3LUi28pPR4URm5SJ3h6C5AZsKXFzfdCL1auFCJyn0+iWUirOxBYIjETDPc7xlKnb1424V9VL6aGTbmNivm/SAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(346002)(396003)(136003)(366004)(2906002)(64756008)(8676002)(83380400001)(45080400002)(122000001)(66446008)(8936002)(66476007)(66556008)(71200400001)(316002)(53546011)(54906003)(5660300002)(33656002)(110136005)(26005)(9686003)(478600001)(76116006)(966005)(66946007)(7696005)(38100700002)(86362001)(55016002)(52536014)(186003)(4326008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DLXjTbond3FzI6LhIR+icQxzkfaOTKpXqTC8ql0q4cpeypL06Z4arZdLb/10?=
 =?us-ascii?Q?gvzsXVdfh6FN3lpARuuuxTZ0cxz8cWFnoULeniTEY0gw+VE1DuF7tVgRJzFL?=
 =?us-ascii?Q?bU4FeoH/qmE4yuF7mUFMiIpYqcVkFJhcK0fKujkfDgk4v6LPXMKG8yzZjWt+?=
 =?us-ascii?Q?6iJiFGb+UzyKN6kUyi4itvhKmXZ5SCV3VXo41Mm2vfBXZnuwB4EmdrsHgP4p?=
 =?us-ascii?Q?I34NX16Y1E6upArAvS8mPc2Or3qeJtt1bXvXBNEolhzYFaJbUI08iPtGqqvC?=
 =?us-ascii?Q?E0zUCERStZIWwBsyt3J31JRB6YoZo1zddy7sg56MT936b0LyW4nikPpiXWI7?=
 =?us-ascii?Q?mDTtBoN7QmqgPi9Ml9eqgCXwzZCoYNtHOWDyyrSthOIdWuxs9wJPY/NTPU8J?=
 =?us-ascii?Q?Y8urOx6nxo6iE2/4IGz9E1jlKVNPQJubl7Jcx0r3Hj2EzWk3VGNvWVXB+jcc?=
 =?us-ascii?Q?TONxyCzwQhfiW4S/Hlq+73lw/T7fTXEi7JLLSYl/Okr3U+Att2GofcW7U2aZ?=
 =?us-ascii?Q?UyVhn9wFD+tJEj2n+ZmkmMMj8Vns1smMc8Gam1yhFqxNmR8JJT2PWqoTtvJ2?=
 =?us-ascii?Q?zk4e6qE2z22h3av2RtNOKiPNlpmxx2bGpsbv98l6Q2MJ2rhtyts0raRF04MN?=
 =?us-ascii?Q?ondjgHzbUdbKsJW+BY9AC+DVX1w9S/lF5TMD/WPl6M4wQpRI2Lsdl0x/4hz9?=
 =?us-ascii?Q?firBnTNABafkQb786401Hw0nIwdSuS4Z2E/Q3n9QNPhxdsk4VcRZjAJKi9TE?=
 =?us-ascii?Q?YMKTEF0axupGW0uXdT3Fbf0yFmXys0n+3+gsGa0jjfZkyqso6uUS92Dy+TJf?=
 =?us-ascii?Q?DM+JJBa/K7OzbPjiuMXEHa8z1GyUMArq59YBS31y7BLwjNiVFVmqC6oWtaBl?=
 =?us-ascii?Q?wZeN4Ae7Kt4szpx3V7jikCWCLaXF6PPv4FputKCD2Z5L0JFmuwc75DjvDCft?=
 =?us-ascii?Q?ZeFaB1aYts8o9BAK2ScG8XgYE1xYd7NqcbVHaR/6SxpUZB/09UWDsQFsj5dy?=
 =?us-ascii?Q?el4+/PVIscqnXMrQz5kkwmRJTzzX4j6izVlmWGckLI9jy1M9DsVXw/JClkUR?=
 =?us-ascii?Q?VmUdkpBq5Czk39Hal0Q8qONNbtlf58qsA1HGvcVv47axX44dJp+40x7kyJXx?=
 =?us-ascii?Q?qdmp/6pcPvOwmN4ZUcOOHYLYpB/8fs0NfRGG+PGFFNb6ZHXKMwIQABcrtTJh?=
 =?us-ascii?Q?k+HlQxbJ/HkuBvQgTQ0sTQqxOoj8oC9ZLDQg9ADNLNxSaVL24uRmA65EKB2r?=
 =?us-ascii?Q?hpNo665lXXNZD/NVOjJ9tPfXlCWQ9DAafdleDvSFzsQ3pFKBAjQKaCc1WfeZ?=
 =?us-ascii?Q?CEuDJnAAvIHAVvpYTLuZQzDb?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268d8b9d-7113-428c-9858-08d91613e76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 13:34:59.1470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEMcVmGg6CiY1yKDuB+IUO+92k5LbOO5SDB7HMLGccyOi6UdlDz9BZKsoED8ENeDHeJ8+eBXf2V4NqsA++XmZA==
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

3 nit-picks inline.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
Sent: Thursday, May 13, 2021 5:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on aldebaran


Use the current and custom pstate frequencies to track the current and user-set min/max values in manual and determinism mode. Previously, only
actual_* value was used to track the currrent and user requested value.
The value will get reassigned whenever user requests a new value with pp_od_clk_voltage node. Hence it will show incorrect values when user requests an invalid value or tries a partial request without committing the values. Separating out to custom and current variable fixes such issues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 65 ++++++++++++-------
  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 18 ++++-
  2 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 5d04a1dfdfd8..d27ed2954705 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -78,8 +78,6 @@

  #define smnPCIE_ESM_CTRL			0x111003D0

-#define CLOCK_VALID (1 << 31)
-
  static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT] = {
  	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
  	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -455,12 +453,18 @@ static int aldebaran_populate_umd_state_clk(struct
smu_context *smu)

  	pstate_table->gfxclk_pstate.min = gfx_table->min;
  	pstate_table->gfxclk_pstate.peak = gfx_table->max;
+	pstate_table->gfxclk_pstate.curr.min = gfx_table->min;
+	pstate_table->gfxclk_pstate.curr.max = gfx_table->max;

  	pstate_table->uclk_pstate.min = mem_table->min;
  	pstate_table->uclk_pstate.peak = mem_table->max;
+	pstate_table->uclk_pstate.curr.min = mem_table->min;
+	pstate_table->uclk_pstate.curr.max = mem_table->max;

  	pstate_table->socclk_pstate.min = soc_table->min;
  	pstate_table->socclk_pstate.peak = soc_table->max;
+	pstate_table->socclk_pstate.curr.min = soc_table->min;
+	pstate_table->socclk_pstate.curr.max = soc_table->max;

  	if (gfx_table->count > ALDEBARAN_UMD_PSTATE_GFXCLK_LEVEL &&
  	    mem_table->count > ALDEBARAN_UMD_PSTATE_MCLK_LEVEL && @@ -669,6 +673,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
  {
  	int i, now, size = 0;
  	int ret = 0;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
  	struct pp_clock_levels_with_latency clocks;
  	struct smu_13_0_dpm_table *single_dpm_table;
  	struct smu_dpm_context *smu_dpm = &smu->smu_dpm; @@ -703,12 +708,8 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,

  		display_levels = clocks.num_levels;

-		min_clk = smu->gfx_actual_hard_min_freq & CLOCK_VALID ?
-				  smu->gfx_actual_hard_min_freq & ~CLOCK_VALID :
-				  single_dpm_table->dpm_levels[0].value;
-		max_clk = smu->gfx_actual_soft_max_freq & CLOCK_VALID ?
-				  smu->gfx_actual_soft_max_freq & ~CLOCK_VALID :
-				  single_dpm_table->dpm_levels[1].value;
+		min_clk = pstate_table->gfxclk_pstate.curr.min;
+		max_clk = pstate_table->gfxclk_pstate.curr.max;

  		freq_values[0] = min_clk;
  		freq_values[1] = max_clk;
@@ -1134,9 +1135,6 @@ static int aldebaran_set_performance_level(struct
smu_context *smu,
  			&& (level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))
  		smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism, NULL);

-	/* Reset user min/max gfx clock */
-	smu->gfx_actual_hard_min_freq = 0;
-	smu->gfx_actual_soft_max_freq = 0;

  	switch (level) {

@@ -1163,6 +1161,7 @@ static int
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
  {
  	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
  	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
  	struct amdgpu_device *adev = smu->adev;
  	uint32_t min_clk;
  	uint32_t max_clk;
@@ -1176,14 +1175,20 @@ static int
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
  		return -EINVAL;

  	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-		min_clk = max(min, dpm_context->dpm_tables.gfx_table.min);
-		max_clk = min(max, dpm_context->dpm_tables.gfx_table.max);
-		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK,
-							    min_clk, max_clk);
+		if (min >= max) {
+			dev_err(smu->adev->dev,
+				"Minimum GFX clk should be less than the maximum allowed clock\n");
+			return -EINVAL;
+		}

+		if ((min == pstate_table->gfxclk_pstate.curr.min) &&
+		    (max == pstate_table->gfxclk_pstate.curr.max))
+			return 0;
+		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK,
+							    min, max);
  		if (!ret) {
-			smu->gfx_actual_hard_min_freq = min_clk | CLOCK_VALID;
-			smu->gfx_actual_soft_max_freq = max_clk | CLOCK_VALID;
+			pstate_table->gfxclk_pstate.curr.min = min;
+			pstate_table->gfxclk_pstate.curr.max = max;
  		}
  		return ret;
  	}
@@ -1209,10 +1214,8 @@ static int
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
  				dev_err(adev->dev,
  						"Failed to enable determinism at GFX clock %d MHz\n", max);
  			} else {
-				smu->gfx_actual_hard_min_freq =
-					min_clk | CLOCK_VALID;
-				smu->gfx_actual_soft_max_freq =
-					max | CLOCK_VALID;
+				pstate_table->gfxclk_pstate.curr.min = min_clk;
+				pstate_table->gfxclk_pstate.curr.max = max;
  			}
  		}
  	}
@@ -1225,6 +1228,7 @@ static int aldebaran_usr_edit_dpm_table(struct
smu_context *smu, enum PP_OD_DPM_
  {
  	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
  	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
  	uint32_t min_clk;
  	uint32_t max_clk;
  	int ret = 0;
@@ -1245,16 +1249,20 @@ static int aldebaran_usr_edit_dpm_table(struct
smu_context *smu, enum PP_OD_DPM_
  			if (input[1] < dpm_context->dpm_tables.gfx_table.min) {
  				dev_warn(smu->adev->dev, "Minimum GFX clk (%ld) MHz specified is less than the minimum allowed (%d) MHz\n",
  					input[1], dpm_context->dpm_tables.gfx_table.min);
+				pstate_table->gfxclk_pstate.custom.min =
+					pstate_table->gfxclk_pstate.curr.min;
  				return -EINVAL;
  			}
-			smu->gfx_actual_hard_min_freq = input[1];
+			pstate_table->gfxclk_pstate.custom.min = input[1];
  		} else if (input[0] == 1) {
  			if (input[1] > dpm_context->dpm_tables.gfx_table.max) {
  				dev_warn(smu->adev->dev, "Maximum GFX clk (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
  					input[1], dpm_context->dpm_tables.gfx_table.max);
+				pstate_table->gfxclk_pstate.custom.max =
+					pstate_table->gfxclk_pstate.curr.max;
  				return -EINVAL;
  			}
-			smu->gfx_actual_soft_max_freq = input[1];
+			pstate_table->gfxclk_pstate.custom.max = input[1];
  		} else {
  			return -EINVAL;
  		}
@@ -1276,8 +1284,15 @@ static int aldebaran_usr_edit_dpm_table(struct
smu_context *smu, enum PP_OD_DPM_
  			dev_err(smu->adev->dev, "Input parameter number not correct\n");
  			return -EINVAL;
  		} else {
-			min_clk = smu->gfx_actual_hard_min_freq;
-			max_clk = smu->gfx_actual_soft_max_freq;
+			if (!pstate_table->gfxclk_pstate.custom.min)
+				pstate_table->gfxclk_pstate.custom.min =
+					pstate_table->gfxclk_pstate.curr.min;
+			if (!pstate_table->gfxclk_pstate.custom.max)
+				pstate_table->gfxclk_pstate.custom.max =
+					pstate_table->gfxclk_pstate.curr.max;
+			min_clk = pstate_table->gfxclk_pstate.custom.min;
+			max_clk = pstate_table->gfxclk_pstate.custom.max;
+
  			return aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk);
  		}
  		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0864083e7435..755bddaf6c4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1624,8 +1624,12 @@ int smu_v13_0_set_performance_level(struct
smu_context *smu,
  							    SMU_GFXCLK,
  							    sclk_min,
  							    sclk_max);
-		if (ret)
+		if (ret) {
  			return ret;
+		} else {
+			pstate_table->gfxclk_pstate.curr.min = sclk_min;
+			pstate_table->gfxclk_pstate.curr.max = sclk_max;
+		}
[Guchun] We may simply code like below. Drop "else" part, as it's redundant.
If (ret)
	return ret;

pstate_table->gfxclk_pstate.curr.min = sclk_min;
pstate_table->gfxclk_pstate.curr.max = sclk_max;
  	
}

  	if (mclk_min && mclk_max) {
@@ -1633,8 +1637,12 @@ int smu_v13_0_set_performance_level(struct
smu_context *smu,
  							    SMU_MCLK,
  							    mclk_min,
  							    mclk_max);
-		if (ret)
+		if (ret) {
  			return ret;
+		} else {
+			pstate_table->uclk_pstate.curr.min = mclk_min;
+			pstate_table->uclk_pstate.curr.max = mclk_max;
+		}
[Guchun]Same as above.
  	}

  	if (socclk_min && socclk_max) {
@@ -1642,8 +1650,12 @@ int smu_v13_0_set_performance_level(struct
smu_context *smu,
  							    SMU_SOCCLK,
  							    socclk_min,
  							    socclk_max);
-		if (ret)
+		if (ret) {
  			return ret;
+		} else {
+			pstate_table->socclk_pstate.curr.min = socclk_min;
+			pstate_table->socclk_pstate.curr.max = socclk_max;
+		}
[Guchun]Same as above.
  	}

  	return ret;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C2a60ef3fa0994b00fb2c08d915f42cce%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637564960746162621%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Rlv%2F%2B%2F7t9fc7vxXhs9vqipWMKhXbKYLj8hHhSh48lo0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
