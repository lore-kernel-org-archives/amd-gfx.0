Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDFFC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B1C613DD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B1C613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4490E6EB19;
	Fri, 21 May 2021 14:25:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8EE6EB19
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 14:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHJw7vuSLg//EpWJ9ltdo1vJeNqUZGhvT2V6FfI16bYRl1upg1GCYlC0Ibqisl7qvnGd8n1kBrx8BM+LWswhddqHrggDvjQs0F+hoCxGYiYpOBeMK67Fe4WmbzptWArRYZgs1lc8w1QTWyzvII7wCMX3OQ1BjeP2d7N22+WlH8lYO9LrMyKvT2lfhMc7WraAm8dj03FeLNp2c2kwec7h3EV0pswa+8JDLjLH3NpVf4BKkvCJ4hPSEMAM9IHGi3eNbprFXWuBe+cp42MD2KkWCO87lBNviCMWuiusV4OKnZKnm6dITmOsbIdgYeVUW9n7a1qHImCNaTwPtWHMp7tBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHf5H3jehxHZ13WSZUmJXx+PfE5zZFiOGx6QKx+bNNU=;
 b=Bj1TI+wcxCxVO3qBeejzgGLduaT6ZCqFqm8tdouawGzTwW7NZdXAwqnjeXRUYA3IbPEbLurDDXCCO9jgrRFZeCM9iiHgOsMtpjT91dMSnygv8ekv0BZ5Pm679bjvcboru4gZrGyIiQ754l1itZ110ecG4qkg6+8xPPcEPHxab7etc8l+/Zhp8B3zxfPRUkwV4dPKAgYEsLhhG5q81dMxaUeXTpLZ585adMDOV8aZ3sNUSDQaizG1SjntZxlXnEwUSslO8Qvf80Lv2VV8npCpLDPzL+HwsoQDU1l5Z0wvQeXWNrolU/T6XCpz49YmL+qI3j8kMKTmz1DTXAZRY3H6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHf5H3jehxHZ13WSZUmJXx+PfE5zZFiOGx6QKx+bNNU=;
 b=IccQ8E09q39aFa6pbrZLpTmfRiTe49y04GXsTVT+1sBZVAQHVXxoT4xPtUcNTTThdJobA1ARkxMlOJM26XKzejMIc3nUHvDWyEXyeim74pPqhw69JDTB40Gapup5jG82tcSoCvOqC9/tUW+WBnWiyXYpCIZorYKizmbb2LpG384=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB2762.namprd12.prod.outlook.com (2603:10b6:5:45::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23; Fri, 21 May 2021 14:25:25 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f%2]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 14:25:25 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
Thread-Topic: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
Thread-Index: AQHXTYSqnKtdoWWDrEav0AgwrHhLd6rt99aw
Date: Fri, 21 May 2021 14:25:24 +0000
Message-ID: <DM6PR12MB2761F4518A785D1E127703A58C299@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20210520142930.8369-1-Graham.Sider@amd.com>
 <20210520142930.8369-2-Graham.Sider@amd.com>
In-Reply-To: <20210520142930.8369-2-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-21T14:25:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9af2b6aa-f0bf-4f6c-8427-ac87e8c678e2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f36a9557-d135-41a4-dbc6-08d91c64464a
x-ms-traffictypediagnostic: DM6PR12MB2762:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27624778DC66C9ECB6517B368C299@DM6PR12MB2762.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XV1OybgAV6M9lIJQTZ8or1+JZwVyNfqy7lCJe+0iJoiwlrWMHitvLlTK2RnK3PhBj78yi+JMGscAShwhaGVOwq97bTmBzUeydv+/bAYDIBNVQ4OYIqco4Z/+X40FL6hQtDicZ32JP2lhzlMP7tBh0y6DL9BKJ/sbwp/S1INcCjsVStANh4YwKaNppGsUbxpCmiva4cudMw9mDkk2F58HEs9ib3kw97kFOz+AwYdPqBjlinrrAfaCEVlls033ikim7o9cqb8P2L5uj+Tj7NM/W2Wm53m3ghK+k+QpnNw/neZG3SV2J/pJvro3YqnBXQcJJWgmVINr801cq11/bWeM5jJUdCjFaD7KYD9UU251zWUzL5qmRD+YB6/HBaEgK23No3EBJymIIi8TB7vFfSYyyT0ZledBDlWfsASlS9bD+CC7x+R+KgQk8Q202FTpoEl89k3LQhsd4DLS2U9inoZ4WYX0ggw7amnVUnWuxUn0UVAMLvM65rFzS9DwWqbtoKYI/MlNpzwZtpn/5tCZ3My4SuHGn4VjhHkX8H5Vn7uSkNHJyqRl0eanxnIP5MRyTj1WcODmRQ8wP4FejJqwMjeHDAZCuCw/h8QHEgLJcng9BDk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(9686003)(26005)(55016002)(71200400001)(76116006)(66446008)(122000001)(8936002)(5660300002)(52536014)(86362001)(8676002)(186003)(4326008)(66946007)(66556008)(66476007)(478600001)(64756008)(7696005)(33656002)(110136005)(6506007)(316002)(83380400001)(2906002)(38100700002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hvNsZB15QXNh5jCQrRhVxHmC+Deo6Kfwwg3HqgoiG8/ffW8LHtZy30V2iBMd?=
 =?us-ascii?Q?IodRyOHMUoDeG6x83HcWeWfsGZ+z5MfrrgZd5OR/vOhMasewtuRa9QxDozXS?=
 =?us-ascii?Q?ygqONf8pHVBJ4jWbrHbx1EL+RpU96Ok2DJaiDkWq9w0JHOdCtX+3Db6R3XES?=
 =?us-ascii?Q?qFyyLSM5OVfOB2fuGLF/bqs0dLDRETxJLBC1W7Xz2+enEXbLzRlaixxleGKv?=
 =?us-ascii?Q?EWuYvT+JzOQXGz08ed6I2G26GB7SZFKI6CAv2zPDfX0//ZVvPXgGkoPJu2cF?=
 =?us-ascii?Q?mBjquIBqKqjKyIsAcNnkc6fIJo3ywohpsfKzkxzJJzu1SmePAoXmCzfHUR/D?=
 =?us-ascii?Q?XLIXwS/WbVwsDtkzfgwxQNjCOUdYC9/cySYT1SwAbuFyvLbtCdhTIXNivA6r?=
 =?us-ascii?Q?3naeCpx8/Jn9ZlBWmzPnWHPX0B6Cfnbw1rC24PiZHk2EK/E3MakfiljV2RZb?=
 =?us-ascii?Q?jDFRJYcs/mUDY1KxoV6RvAfw37Nop4Ctgm0QhhO0StK61jdGgydzolTOG6aq?=
 =?us-ascii?Q?h1BxnT/8I4BYIVt6E37TsoKMtDOIfxTxCr9ly8Oqq1RBlGtObZHq1+/Bmm4B?=
 =?us-ascii?Q?ByukuFfcVRGhHwlxPF8JFqaKm4lCBESM7g8DiCCIPizcxsihG91IK5nBcGmc?=
 =?us-ascii?Q?oONm6roA4bkaP9gwtKHFp/IsE8sd7/FB/G3J4QhrF5lwurBOMfyXWJS8ScEx?=
 =?us-ascii?Q?mv/fWjNEMa+6+HtlghH2kgwouRQWCdagFIob2ZbpLRaO4kb4ek+p4kToyzHY?=
 =?us-ascii?Q?CI21+YO/tlZ55tvX25DupNblh3qbapUCgaOqjw4ybfzN3sVN6EL5ePnGLFog?=
 =?us-ascii?Q?Nl2YtGO5kUzyM50QNiHTSehdMC8tCgjWi86vNxNXqFlxi+H30xSpBSwXkGSm?=
 =?us-ascii?Q?DKMS6x6lGm8pnSmZTN1NVOJ5edQhkSlWPTaDWZwibmAxbpRGdHBcps0u/01y?=
 =?us-ascii?Q?YnchHXZsV6PvWSz2wz6kfTrHmFWrxvg/JKHVk3KamQH7DQowOTgEFb+iGNP2?=
 =?us-ascii?Q?vpXwf6BENJib6MZnI0+trM72jxP4vahCGP4kzfA5GEGUTKEWHvAODVNrwHoP?=
 =?us-ascii?Q?xXsjU1GdxKGdsNfIudit4SwJAyzfpNFF49wTktx6ASu6dodXSCcnWle3p0hJ?=
 =?us-ascii?Q?oMZDo2KqWuLLwpayBVaP19PrIAnhcB5t69bgLmQXXnxFitup9GPTszs0Sza9?=
 =?us-ascii?Q?ng+datchGCpBXZMr/rkayVc4uLyuR2iycQzB/4zX2xzHjZGjL/iOnfBOj8ZI?=
 =?us-ascii?Q?CW2IIG72SBuW1E/d00fF+IkTmklpLAWbeXaVCDxEKYBIubDFjIP36Vm6vvQJ?=
 =?us-ascii?Q?b29K4qDY4Ta3pqvG1mgTwbN1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36a9557-d135-41a4-dbc6-08d91c64464a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 14:25:25.0304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLwDbn/XaV6UHfo6VpNTlDdzcsU8csPjUKYDoBIogbRPpLlkC57bxZ/Anwucz3M8AWRW0HuDZ39tgmwofI5aCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2762
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
Cc: "Sakhnovitch, Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Graham,

This patch series looks good. Please add "Signed-off-by" to all the commit messages. 
One additional comment inline below.

-----Original Message-----
From: Sider, Graham <Graham.Sider@amd.com> 
Sent: Thursday, May 20, 2021 10:29 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>; Sider, Graham <Graham.Sider@amd.com>
Subject: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation

Perform dependent to independent throttle status translation for
arcturus.
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 62 ++++++++++++++++---
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1735a96dd307..7c01c0bf2073 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -540,6 +540,49 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
+static uint32_t arcturus_get_indep_throttler_status(
+					unsigned long dep_throttler_status)
+{
+	unsigned long indep_throttler_status = 0;
+

[HK] You can a simple optimization here. During most of the time throttler_status would be 0.  So if (dep_throttler_status == 0) you could just return here. You can add this to other commits too.

+	__assign_bit(INDEP_THROTTLER_TEMP_EDGE_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_EDGE_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_HOTSPOT_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_HOTSPOT_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_MEM_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_MEM_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_VR_GFX_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_VR_GFX_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_VR_MEM_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_VR_MEM_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_VR_SOC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_VR_SOC_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TDC_GFX_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TDC_GFX_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TDC_SOC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TDC_SOC_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPT0_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPT0_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPT1_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPT1_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPT2_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPT2_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPT3_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPT3_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPM_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPM_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_FIT_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_FIT_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_APCC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_APCC_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_VRHOT0_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_VRHOT0_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_VRHOT1_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_VRHOT1_BIT, &dep_throttler_status));
+
+	return (uint32_t)indep_throttler_status;
+}
+
 static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 					 MetricsMember_t member,
 					 uint32_t *value)
@@ -629,7 +672,7 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = arcturus_get_indep_throttler_status(metrics->ThrottlerStatus);
 		break;
 	case METRICS_CURR_FANSPEED:
 		*value = metrics->CurrFanSpeed;
@@ -2213,13 +2256,13 @@ static const struct throttling_logging_label {
 	uint32_t feature_mask;
 	const char *label;
 } logging_label[] = {
-	{(1U << THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
-	{(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
-	{(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
-	{(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
-	{(1U << THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
-	{(1U << THROTTLER_VRHOT0_BIT), "VR0 HOT"},
-	{(1U << THROTTLER_VRHOT1_BIT), "VR1 HOT"},
+	{(1U << INDEP_THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
+	{(1U << INDEP_THROTTLER_TEMP_MEM_BIT), "HBM"},
+	{(1U << INDEP_THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
+	{(1U << INDEP_THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
+	{(1U << INDEP_THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
+	{(1U << INDEP_THROTTLER_VRHOT0_BIT), "VR0 HOT"},
+	{(1U << INDEP_THROTTLER_VRHOT1_BIT), "VR1 HOT"},
 };
 static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 {
@@ -2314,7 +2357,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->throttle_status =
+			arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
