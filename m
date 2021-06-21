Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B726AC49EA6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BF26054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BF26054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF08C6E296;
	Mon, 21 Jun 2021 17:13:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041C46E250
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arDBkuWk9UssWYUPOhhtEVZV+QkDbZprX6sry0Cr2uR5ORe3K8wBTBn0rFyaeMS4sHrCs3Go8Lo6jTHlI4rJ9HHbWHWRrAecKHlsCxuOlBl2IGMQhrIbIei742PQKufr2qHrQKhKajjBNjO//hit1FQsx/2qD6XTWGQ+Rx71k4Af0bbApm2KfO2Mp/6fskbx/oblr0afhT1Vv2RJvO67Lgir80c9f/VtCW2CLWRPS9v0ICOXr0j0Ry9A89ynv1vx07hyx/wQar1sKgw/Cl+T23hOGry615jjpd+W5wPu2OM6mIxcStLlBESeUP7t7l7G6w71K0qSX8U7Vk2CLBq9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3aW7ZVVRZenFeUpewa+/RsiZuxHUnLtcahdRgYbM70=;
 b=TCBT7Itqn+Q2O/NHq7RGak5aE4Ndxa1qLwX+N9JRjGyryHtS5CA/gaW6k+4bpvV9pCVcM4vv3yf5OV7rgUBBoZJrMiXj3DRap6ikz+cgT/2a4+G1lShvEwLnZaaSmiC6JfNLgNUSs7WCTpRtDSWksJcc+fkVJy0W1kaBIIq/dp29fO/6zr6E93NS14Lcn5a6Y7KNEdoNhamOTfMNPTPFF/0XU8iOEKcZxqW1l411IEKgFk85oNNCov1CLEKb/o8q8R4yFIzvBBHdXzLzGyFd3uSMKrgLPqqa0WqopQIifJk1jsx+ZuTsvwnRQBlRV0bd1qisNvL8a0ndR5EIfVmPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3aW7ZVVRZenFeUpewa+/RsiZuxHUnLtcahdRgYbM70=;
 b=aGJSHuPStMp/aCzighrNBkBMYaFwE9oaMFG5xd2cpuoow/Lu9S+xgR4e1L4V8u7zUu3MVZLF0qMXETQRddMKECT0ulvWIWZdvIdHUpLpwtKYXGGPAs7b8oXkRtIR4Hjli22I5SFOJ9WHYT3lTkHLvKQVhs0wA55JSuy79J5qDt0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 17:12:58 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:58 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/43] drm/amdgpu: EEPROM: add explicit read and write
Date: Mon, 21 Jun 2021 13:12:06 -0400
Message-Id: <20210621171221.5720-29-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8452a33b-6f1c-4192-1c29-08d934d7d0f6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258CA9874653E3D03F8ED6D990A9@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECY1rLHRgwh9Z0R6qGIasUV61+/7Hgzyovk1ap/7g7a3Onoewz4qcziuY6X5VTXzKmKR1xVQhCYe2bn9QV+Da05nEewocYhsFI/vdKEbCf3SyljnAv1fJF7ARm1Hh1/qbB0wPH9rzmOYDq68GYAkwCW62xXUwaeo8L7oNzBgEoEXb1WuwOJSAWUuCRDz5HJlZz9ACyDg5GcDg2IZnJT8ZXDZ+HW/8LNdQKIwYEN/LwhloBkfV8pbPvFUZDDkarMZuGmu8DQpsbxN86Myhs77xiEKkR6nbQZq3epj5my1Vd0mIvC4soUc7uXu+SxBqNB3/H0AgA+/s7URfr1wIddzYbUbKdiOJHTAyZZheXpeXch0nH8o6HCdBQfv14H9vWnf4gBFfxXSvYoWCqKIQ0GddYbOZDKwKsF6kIheK9fDT+aOrB1oLmWqGsyfmAdX2uGMmBWr+dbKjaDpVDC1gP6/yh8Vw4nmfnvIGxj2p6UTk7ch/ZeB5BYSy5YA8z8iZO3s1mviezcW1TVkVKMhWYYqSTnOwlRemjkDjT7eFErQTwkhne2bf56oTnEHkXHw/3ycfCVOhVkJErtV0ntkQic1bXOreGaP2ViXO627YIQbyvmY2HRkGwI65gCc8s/8CU7spFdaa5XB378Z9EixHWXMalVxaAGLWAAFvSEemhE9fF+OELTNFuWt/TE5DtUaaLKf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(55236004)(956004)(478600001)(8676002)(8936002)(54906003)(44832011)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(6916009)(6486002)(52116002)(6666004)(86362001)(316002)(5660300002)(186003)(66476007)(66556008)(6512007)(4326008)(16526019)(66946007)(26005)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?caIWkZA7yH/zVlHSX3mo7hECPwUnNF80UQMoJpnPtmRY2XGA/Xp3bUhJ8K/h?=
 =?us-ascii?Q?7PejlJpwRwitjZrF4Ab72AeIsaBY0w1nFzCsNmpAz2pU/J/XihYl11Bs1vn+?=
 =?us-ascii?Q?Y/ikE0ErACztAaW4qykNqnP15TAq85ZkhK8XnKvzpTUQZXO1N4eqNubJsyFg?=
 =?us-ascii?Q?7ad2mfUlrRhRTDsXsSNEsRn7BzrV0p2Leug+RveLGmpmoBpUy7l7EYSacnAW?=
 =?us-ascii?Q?t0p24St7Fm50Lu4CocuBW0Rtd2HApq8zHxxfZ2hJNqhGRdEU1eOVc8wwGVm7?=
 =?us-ascii?Q?DVqTN/xECP52cX8/arjpf3v0KafpbS25fcitEal/+3mTqQluO+MPWQRXzPZj?=
 =?us-ascii?Q?Ele6oQPW0RxbP7FplUAZRTmFRCdPh0H8nlN+6OJzTsQO1t5OgdvY4Vq3TjkQ?=
 =?us-ascii?Q?j0iRyymsXSP39kk0Euge/aHNNvr7hSzvyY+bXI8UpDndakIAUIyNYJZgMeZ/?=
 =?us-ascii?Q?dKwBcoUSs2kn2IK9FEnisfT9QkfHujvUWDo1qsT3XHA2623OJ/f+iicMX0jw?=
 =?us-ascii?Q?OtQojfb/ujZlxAar4PcXHamRj1i2MziPaPDMZPMOUFGYfbf/BQciXnBSrmdP?=
 =?us-ascii?Q?n0nizoSTxlIqGLBjmBXeWk1+ET2cMhi3WwhIovx9yuZ4BCtwaEyWIMEZHBbB?=
 =?us-ascii?Q?0uip9I+rIQAJAvhXQyrV6CQjBvEOMK+GOl3lfvLSP3CZBZXM9OMgixcydPjR?=
 =?us-ascii?Q?7vxcJSc8WX7j9nF8UM9RGgWDzuw9qsHrAKX+roZ+tm7nM6DHZq7J7Wb7i6AW?=
 =?us-ascii?Q?IA/AeOz6S/yrUaoZctn5WgYpMnj2juFGVl0UcU+DKEifidCbb/5dOLBDGeFp?=
 =?us-ascii?Q?em+B/jDECuzocw/o5ULZLAZw3F0C35d3EgX3qrlrdagVoCZ9m+JPmFJCZ36U?=
 =?us-ascii?Q?fz0G56jDYP0qByDD+h8vD/QM1ozWDVSatQE/5HBjVzCOAoePKoQRZCcApGMo?=
 =?us-ascii?Q?SD9djACjq1jTq9BeLmd/QPBkAM9RiHT8jFlBOSBepI4iHCDZv7CJU1lEyK0Y?=
 =?us-ascii?Q?BsXXrX+Yu1/UrvgZ54OjGoEjQZxZ6AMYXMbWsalY9+mfph1OXPKul8fG1cHl?=
 =?us-ascii?Q?yO933RpAYN9xcUr4hG0NrK416tWvVtmNItSF7bEGTTpijXQUemf6/YcqZ7bO?=
 =?us-ascii?Q?2XcbPx9WqlEkm+qIQ/0OfJJ6Truxwef8rc3HcVxs6bg4uqrVXVkKTyVyPcU3?=
 =?us-ascii?Q?cYVm3wh57M89zG+TjVNF1WQZU6jjVA9NZd2uiuRCAgKoqugDgBbcgTYqSbaM?=
 =?us-ascii?Q?xz4SJBgotQPoDT/sGO1qmPxvkoO87RbrpvLQqZfUjhHb4kd5vxZIfybG6mMJ?=
 =?us-ascii?Q?nuxhrpWP++E6eAWfpa1YmCmr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8452a33b-6f1c-4192-1c29-08d934d7d0f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:57.9128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfUMImDWFPeVnBUZ/baf50epmB7zBArrqTZ5IPUIPyx09nWGzynomxuF1cN8E+VJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add explicit amdgpu_eeprom_read() and
amdgpu_eeprom_write() for clarity.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h     | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c |  5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++-----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
index 417472be2712e6..966b434f0de2b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -29,4 +29,20 @@
 int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 		       u8 *eeprom_buf, u16 bytes, bool read);
 
+static inline int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
+				     u32 eeprom_addr, u8 *eeprom_buf,
+				     u16 bytes)
+{
+	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
+				  true);
+}
+
+static inline int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
+				      u32 eeprom_addr, u8 *eeprom_buf,
+				      u16 bytes)
+{
+	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
+				  false);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 69b9559f840ac3..7709caeb233d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -66,7 +66,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 {
 	int ret, size;
 
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr, buff, 1, true);
+	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c, addrptr, buff, 1);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get size field");
 		return ret;
@@ -77,8 +77,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 	 */
 	size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
 
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr + 1, buff, size,
-				 true);
+	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c, addrptr + 1, buff, size);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 550a31953d2da1..17cea35275e46c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -151,9 +151,9 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 
 	/* i2c may be unstable in gpu reset */
 	down_read(&adev->reset_sem);
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
-				 control->i2c_address + RAS_HDR_START,
-				 buff, RAS_TABLE_HEADER_SIZE, false);
+	ret = amdgpu_eeprom_write(&adev->pm.smu_i2c,
+				  control->i2c_address + RAS_HDR_START,
+				  buff, RAS_TABLE_HEADER_SIZE);
 	up_read(&adev->reset_sem);
 
 	if (ret < 1)
@@ -298,9 +298,9 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	mutex_init(&control->tbl_mutex);
 
 	/* Read/Create table header from EEPROM address 0 */
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
+	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c,
 				 control->i2c_address + RAS_HDR_START,
-				 buff, RAS_TABLE_HEADER_SIZE, true);
+				 buff, RAS_TABLE_HEADER_SIZE);
 	if (ret < 1) {
 		DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
 		return ret;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
