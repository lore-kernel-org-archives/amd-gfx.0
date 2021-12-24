Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0624AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Dec 2021 02:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DD510E3E2;
	Fri, 24 Dec 2021 02:54:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E15010E3E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Dec 2021 02:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkz2rvvzIgLoknteWJ9mYA4Br39BDwIjAgqSy3w4TDpC+1qockfLvEt71g1HusLaOutHN9SzkKV4ABs5zA+GZNQSYSD9P5LrFRgqx4rectMkZNwx7NauNmthkAflMb2fBNSQZAtVkVbcvHelzZWH3C059s5VLZhbyk/rQ+zerq9BuWJcth8KEY7ZGrf8acXmpmJS0f4ZS00iwP3sOu3diWoSeTX7WpXT+eivwvr6L+iC9Zr+2BaROvGeVuAFPpNo8j3vVpRJnxPKLXZBIquIqrY7zHq/ffqdgZfLXBd550gZCCr26teM4o8BS0ya62MRiullsO4HgCWhyua0W9vbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3+lw9oOvLzYSS7WqQ53uCSCbXQt21Y2y2bfqRmz6Qs=;
 b=TMblZrMciBr07+1R8ORfodyT5dfMnE3EpsgEsY4ao41G/w7eW84OD2oM1rWoBNuD/rhzpRtAQrhfMEEbKW+A86w5dpXiiM3A86/fl9zfXEQHVsfMcjUinYu8nH5K1FYu9C9oXKfTFndQgFGMTBc/Cz57vK1R2ZRxzWaBJhNcfhud0+pIvxoySLhmc9plV2iXsNph541/E+p94ENN3Vt7QnUBsmm2k1wNsvF/eUoSRFtm8xAuSg2qo4j9FiI0xV6P/EZ2cWxD711WYz30VLCiDN2+NgFKf9x8MuUlVzCH2j7sM75wvSdDWO4sBQe1w5YcnTkMLAEZpJq5AAqyT3ctoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3+lw9oOvLzYSS7WqQ53uCSCbXQt21Y2y2bfqRmz6Qs=;
 b=T0gYeV+d5xqXddttSQ44Pg3HJfMJnEZmEfNCcfXRIoCbtpyk0qhferKtdpX7WLyqJyMru5ZDU6rtxLTpKbUmWFzcgtmnBK07ibTDn01HGZbHXT2NqPatvFJb0Pr/OPPBff9hblwgg0O0WUZvpsz391SG/6QYiGzYUtpKPL1gatk=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.15; Fri, 24 Dec 2021 02:54:00 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4823.019; Fri, 24 Dec 2021
 02:54:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: no DC support for headless chips
Thread-Topic: [PATCH] drm/amdgpu: no DC support for headless chips
Thread-Index: AQHX+DIXUSMt6ytPmki1kpsriwd81qxA8RLA
Date: Fri, 24 Dec 2021 02:54:00 +0000
Message-ID: <DM5PR12MB2469BFC66394EFEA7625B131F17F9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211223191934.1269698-1-alexander.deucher@amd.com>
In-Reply-To: <20211223191934.1269698-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-24T02:53:34Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f0fae9a3-0d15-4796-9419-e03d821b5cc5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-24T02:53:56Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0ecbb051-7d4e-418b-8a54-de3f861d2e0f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 894088c8-8153-4ca5-5d95-08d9c688a309
x-ms-traffictypediagnostic: DM5PR12MB2504:EE_
x-microsoft-antispam-prvs: <DM5PR12MB25043EDB9E53DE92CEA8B39CF17F9@DM5PR12MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: edVONN1o8eF8/jk1zDSRojxCFKX/2vP9/t4aCszk2hm+ceauqIbOOC45tOqrgmB78EvoClrGcGEzSCc7IF1hf93qnHcR2fyA9pHMlXYtSNUTxyrZTu7aVQuzndw+Tvi9q6CEv5V8OOw1DfASk7Awb2ok3Yr3SN/Gl56YviN+I7KhlI0Q2nUo1FNUFscjpmWfxJi9Yxev0JJ/nQTlFrAuOXbacarBQq7KfMfkqbRT1srlE+tXlZ4OY67o1orXdlyUgGN+oV4L9E4LxGzYRG6qklRncs6QW2deysbA6z1RJT4kbQyZ430tZa9EOmwTp4M+evdAXulLn9Rh/OQJewujFDxnGPi8TXWaH/Mru7byRQkp4xKkiJ647d97XNdYUwSsdja5B2DB1Uz24zvnu0Zd/fda7gutsAh/2Ciz7ET3AUoO+XiP/TM1ihuUrFCU/AIihudU4+7BAzBndn3qpiy5fbvSN5b1QyXSVgWZovgI77cgDXVo3sEX6uDogExvHYRnRyclR2+mj3WBL3wpWMvT582irx85Jmr6/Ocaw19XQ4ZMo6DbvNDLrnUHdQxM3vKP4DjlDC8lASx5KHzsjSsFtT3uLBvxx2c9lNLT2lmNXTs4pX35lV2alEJJ8L4fbzp+lR017uZWrxoWDN1TwNDpz9ru9LmouGXCuH4iZ8bb36UVfVoR71XBxZAbA/tyJ+mmwCKK8IA5r4pkOJSwfoXdEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(76116006)(4326008)(38100700002)(71200400001)(52536014)(9686003)(66946007)(508600001)(122000001)(186003)(5660300002)(8676002)(64756008)(55016003)(8936002)(316002)(26005)(38070700005)(54906003)(2906002)(86362001)(66446008)(83380400001)(7696005)(6506007)(110136005)(66556008)(66476007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wU73fwWHKwtTcG2j6EHkfAEJgayDHmNonVkTlEjeeXG5M8CrXsG0s4OGRpED?=
 =?us-ascii?Q?mq3jXrbMupUD001amA3E7WWoMnOD8Q+b9aCnPLwR4z9jw0sNxn/wwQTtn3+a?=
 =?us-ascii?Q?ECdmNuuMEZxK8JTXV2t1f1V7gZfLdzRnV5cnn5p1J5XRCd/iHtdmLo6iWcfc?=
 =?us-ascii?Q?9eqwuhDD2+ub2g3amCgR9Ar+Yk5WC02i+7mUtAYZgG0WCZXvPA5wDVCS2AXr?=
 =?us-ascii?Q?1m2ZC8I/HF6TKZ3HRQOInGgaT7phihbb+pnWvYgj1Abbf75X9zGY16xDrrP5?=
 =?us-ascii?Q?KbOM2ZP1OVbqtlJx+nVowaZSdb9lGl3r6wxDa4VqGrZfVLDJCe+YH5Qvhz5N?=
 =?us-ascii?Q?K9FTnSnRjE+BN+SKJyVJ0/sTu+3GNgfr5yBbSWk1DW5ntC1bsMe4xs9CH5JB?=
 =?us-ascii?Q?WAdzI9Sp7yXv4XGSmbu/dyCEPfpXo021ErJK2uX7QyEVBm9W7f+sc5hITRNC?=
 =?us-ascii?Q?FjPZDhNV1UbN4KuAY6g6m/IE9flo3v4mGTu1zVtnKNLGyMIO5+Os9LPCnBUR?=
 =?us-ascii?Q?pc09ucT62uyC46JT2FDFTXZ5UgrT4cVRxghpld6TPrVTuec9b1LRM+VvhHyf?=
 =?us-ascii?Q?EZxevdub8p7cFRL4Zzs5lAXxaZFp+zJPZaqimJA/aZd5uvGqEVQZnkaDxL0P?=
 =?us-ascii?Q?zRHPPYiY5YiUPMk/aOBkEJ006MKkhkCA5TOAVximISqrG2v2e8JEuCPY6qEl?=
 =?us-ascii?Q?kZkeAdQg1hGP5tK45l7vwm5r+yLQHdYIrCcsree2DiP5dILIPOiddypFbcfm?=
 =?us-ascii?Q?bW8pnT8nMSmq8mTE8BHW7HrWzBcZuLPdvQkKoLRsmoccDYWJKBQuISAtaBvA?=
 =?us-ascii?Q?YaaqEwDSjCO6dRaPcX3AjM7AxFEyPbMxhleRK/fFiAw1gEnFReqF8QuJDawR?=
 =?us-ascii?Q?ieNqt0dwffJ/e+pEAT2l/CwMWYp4yh500b6rJ5w9KeG0WFAQ8cNtTAllAKsM?=
 =?us-ascii?Q?gja92ZZx8214qaV4dIHaIVnYmwqvmiFVlY+Dgprsnu4v2NV369+qwN76u6LG?=
 =?us-ascii?Q?oAo4Dpf//fFLReCJ0gEvIUkpFTslSBYEbOKEccJtt8aWXFKRNjPFxdVx0w6N?=
 =?us-ascii?Q?KRj8etOX+8SxwlF9loJnTq+oE/jTZXSGd+RY1v8p2G5C6It0ODYKy9Q/JKgd?=
 =?us-ascii?Q?vospj6afT0SNNxLfVirrWPHTeDDrXrO1OSzpRMUvEs4v09LWh55jiHZpiwir?=
 =?us-ascii?Q?hfkBz2JEzXcWFqIkh+4yfPN8fcCXYMlalAHkP+I3XvIjTnKou/IgbCRCyoDT?=
 =?us-ascii?Q?QkqLyuQbdprTtxH7adQz8ee6LXDxUK32l5LXbFzOjVqI6/DSJcPSlMMtzJbu?=
 =?us-ascii?Q?IB687tzqArX2eDbFqrzI5UWWTwbeoUttdXT5uGmCHCY+RJsW7gy5nErNIRRH?=
 =?us-ascii?Q?9r6LioqiyfUZP55i8uATRCDojA0gLoBnFLaTPqqOqu3QWQr8lzn7WYIwUA+/?=
 =?us-ascii?Q?gZbYPmFwHVtM2jbuYRwArja9lNn/yx4SMEWQqVQ8vHu+n9vqMhQvH4ebX8se?=
 =?us-ascii?Q?GuJFEm95Hb21OILHGkYEETAq64N/rh9W3LUCFtJvqA/9lw52MMTHH3gqy71m?=
 =?us-ascii?Q?j+/TAOjfa9kG+0ivs/yp2dxY0pVi8rjcm0sczQRV4XRsmRCjl7oljJP+d4pq?=
 =?us-ascii?Q?rNCxOgTjsB1/zBjUQQ2mLkY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894088c8-8153-4ca5-5d95-08d9c688a309
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 02:54:00.1850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VUhyyLZGzhP1H22eugYur/yaL8jSIKVZXxPBEF431jcmA4EAw4oFMHmjJfAPXzkAlGvnU0TZxURzoO2ZMoskg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "tarequemd.hanif@yahoo.com" <tarequemd.hanif@yahoo.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

For the first two CHIP_HAINAN and CHIP_TOPAZ, using asic_type is fine. But =
for CHIP_ARCTURUS and CHIP_ALDEBARAN, I wonder if there is any dc hardware =
harvesting info carried by harvest table in VBIOS. If that's the case, I th=
ink we can drop these two, as we can promise it by checking AMD_HARVEST_IP_=
DMU_MASK in amdgpu_device_has_dc_support.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, December 24, 2021 3:20 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; tarequemd.hanif@yahoo.c=
om
Subject: [PATCH] drm/amdgpu: no DC support for headless chips

Chips with no display hardware should return false for DC support.

Fixes: f7f12b25823c0d ("drm/amdgpu: default to true in amdgpu_device_asic_h=
as_dc_support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 9dc86c5a1cad..58e2034984de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3166,6 +3166,14 @@ static void amdgpu_device_detect_sriov_bios(struct a=
mdgpu_device *adev)  bool amdgpu_device_asic_has_dc_support(enum amd_asic_t=
ype asic_type)  {
 	switch (asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_SI
+	case CHIP_HAINAN:
+#endif
+	case CHIP_TOPAZ:
+	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
+		/* chips with no display hardware */
+		return false;
 #if defined(CONFIG_DRM_AMD_DC)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
--
2.33.1
