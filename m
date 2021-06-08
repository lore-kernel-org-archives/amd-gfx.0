Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6E5C4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D3F610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D3F610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E538F6EC51;
	Tue,  8 Jun 2021 21:41:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0096EC51
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnu4uqDXL9Vmx7BqEM7ODq+8NSUtDyiQucEscdhJ6O+dspe1G5sSxsN78/EevOoSKlOF1HNH0JNXwXlfgdB17fjYaACzlHfXVyJLw4vxjAo+i6bPq/XVeRtg3QdJDLhlFx707zr5j+RwzC819pk8VyBsx6WMd6lPVqbsDQY3RMQT4n3JqSckwfMLwtfY4pIo9dMwHie1VHefhOwgRNhh4/NAf+FgepGI9hHLo053iQpqsX5QwsfWj4XniliZLmSx4j30ojn8BZbWhRgRDaj0IeVxaCLf/e5fShxgYLhlZXzUvJ2O7UjgfcoAuJ0RaKeyJZ6EjZBci7GEZFVr6CNliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wItGik+OOQKPUjO/+2vneI3ARVXZ67K73hkRjwqKybU=;
 b=gkXWRGzwIVKVzvC2Zqalre/Iz/kXlf9sf3qSN7nhsow2xiFN25Wlj2q/c3Tg+oqrzdvtdDpJvEzqC6Ia+ohSe3/PirwcUIXZClYkD9ceuZGB98cegICe8Cwosc400HI3BPl+GqxBCrkY2iHGZNeac0E3yLI6UXd8jcGr9WqVH9baYqQvTfn9mMxMfrDR7ehyYjHegN8lnm8eVnnpx/ZpHE+8F8ZRsHCfx46iG0QoJls334MeP3JjGDa6qZxArxVTZeHFg6M8ISW5wE/9Aon6Pw9tN0WRYjyVOSHonUKWSTWAygooyT7obHsX0e/p6KhRepdBakAERAE22rpRyCvuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wItGik+OOQKPUjO/+2vneI3ARVXZ67K73hkRjwqKybU=;
 b=h+13pRPt71Ea1po2LKXL0ZckkJaSIqReaSiXMXvtJZA3G0RS5ciUNFelUbYnp6cfsj1p7dJcoQlTV7kwEbMdh1VsSPlFQ2VE0Xgk9fRZ/CnEpIoqc8sDGkDBkHkkOxthavuVZUTgeSTtkFZuL17e1mAf4jI2lW+Dd7OGM6l0DVQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 21:41:10 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:41:09 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/40] drm/amdgpu: Fix width of I2C address
Date: Tue,  8 Jun 2021 17:39:45 -0400
Message-Id: <20210608213954.5517-32-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48e9072b-63cd-4489-6d38-08d92ac60f65
X-MS-TrafficTypeDiagnostic: DM6PR12MB2780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27808428463B0E48BCBD11B699379@DM6PR12MB2780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sWztCDAv74Zou//4A8B3zB8UO2Dg5vK55jYCMZHsS+kyyfJTVhPwBqFHEthG/GUcuwn5qJmHRWW7fbCee9d6KFAY6fg3JdC98JwdbvFFIx4/2nX3n7Cblr1gVEbmvmifUSyfUMO8wH+5z55fkAPY/IL/xDdcmBOAxMnGUCtgfGNd00HOhKprMzijvWSTLmCX10dMfh833vQ3+CEU5x6ddySvAmFQ9Y5X1n/ugDRSDVJX/+8BrSYOfEYBdSP1HgY3Cc0Z/iNCvkMulPiilTcJtUuGMn0L2IV0/EAYAkleUsnD4dP/ZkyFLmiYhuF1vFrT/Uhg25WqtYytAz8Ad4B0suCQZmx4n1qCOGgwgzLBEGf86OSfKvpGgLkXrEmCO1NOJJde3mQkI3c1XVgOG17pV26iz/2/OuI2ag9tK7jIwz16Wxw7KLOCUf/dVHjNbKQXsWkJjCYFZJua2uORi1Q+aro9hmZp5XEqtbZI5bO+fi8nr+E1A+EJg8vHLhqLPgxPIbwA67khWr26VbKq5X2dCvsyQ39tB3nOZkNkERGpq+rA5DnQa0wCUS78WoWcIxJZQBpnuqq4HztxjprYjamOqQ0nCGkJ6Rxs4Wb76ttopk5fb+vZTuK7sWc+Ht1V69n6/Y39keWc16vCOgV2+1PsWjbaVDA393aoxOIjUyM4FHOsvAYIoXRmtYvLQLGoYQl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(376002)(396003)(136003)(66946007)(6506007)(54906003)(6486002)(6916009)(86362001)(316002)(16526019)(478600001)(2906002)(38350700002)(38100700002)(2616005)(52116002)(55236004)(6512007)(8676002)(66476007)(26005)(4326008)(8936002)(83380400001)(36756003)(44832011)(1076003)(6666004)(186003)(5660300002)(956004)(66556008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JYD4V4gxDBhqGQCOLaiKfCGde5KY4OhZ5+1ahiUUxobuSpU30Ixcc8dYQM6s?=
 =?us-ascii?Q?pU3wQzkEdzS8ieFuGaDlXr19qH45uFYHVZKmcxZorXxntIVouNd9bRjRUY2H?=
 =?us-ascii?Q?lHJwJutuA3JujIQ5BtKlggJO55ysVvGaPe3MMNt0e73BTbMNcjTfQVegQhuz?=
 =?us-ascii?Q?3QZ2mu/+ljY5EeqdjrshxGx/BmLVtfUShhKbq1yPOLtHOzaelm+tmuIunQrn?=
 =?us-ascii?Q?XQvvcpoCR9YLqyMC07EHeJ1mSUloXaLTZgM2TIyEonqMxazLOSqphcuXrcv4?=
 =?us-ascii?Q?sdIXf89ISzJ0tRkFRJlvfP9CdrpcmSt4TYzjW4CoPFuVHYlehz8KHykgFGJC?=
 =?us-ascii?Q?I/QgbS6a3F196DfcRTkNVAxoALBJ6prAPR/R5uIRiFJzzLnLoqLanurK/5Jb?=
 =?us-ascii?Q?ZGvt9FODfPbo44XzasaGsqHgwmnviNunH9HTzQ5P7FqeileIW39CUQ9AFYX7?=
 =?us-ascii?Q?8XfJ3A6yxQFWlZqVGu+RO7PbTgV/xIEuJjGD7qwTA1FE1Cyyt4KWW+gW6dfz?=
 =?us-ascii?Q?ZM33KoFSTAUe6SWsKsY+puknQ0feDSVlckmBjRP8hLZeCi/Wyq854BscvySV?=
 =?us-ascii?Q?m5CClJ08fZO0EMjMb4KPJXq75wgMLSF+iFFdnqVJ7yjol6IqeG0At3yXmFzE?=
 =?us-ascii?Q?/UXTW2eYUlh6uDxha56GPsUPMCYSCo0JU1q8UsjQ8fDHYxrM6qzsdTGKH/8C?=
 =?us-ascii?Q?dHRTbfnnISAmdoIWu0dMRVX+255cglhNhnNBZqjaLf+wisaR6aIlTJ2BUsNe?=
 =?us-ascii?Q?S4r8UFApOQvofU2oIEPJQMntyUOu/oGcHepP3YmZ81g5bemlg5BJyex5qX3F?=
 =?us-ascii?Q?HJDBaoNMWLs3qQ+LqMejgX3wCkPi1qLbUSevpx6l72gUezCAPvf17HjGtdlu?=
 =?us-ascii?Q?DxD4m55g5fjdfygPD/lLuwH5SQ2dk8MVFOFoiUhBL0+Ol/ybVJaWFXS/MYCo?=
 =?us-ascii?Q?DivE2l4rXWx9KzKkQVRR+j3LFWy4KqcOE1VJUcRmBhE5nc4zF0/x1SKoFgO7?=
 =?us-ascii?Q?WLtfWz8UwWF3eHoLLJBoaLNj0K3AxS6MU1q/dkAQxX8myP2FGF+YqnxurvuQ?=
 =?us-ascii?Q?zdFhuFuYmw4+aED52CYIpNvYaDRl+fudiNMZhQs7Ni/csgp6sRIsD5ntRqnT?=
 =?us-ascii?Q?1a95PnVf3NLc0JksOKXXUz1HRCQAAQgYJXktptbJF8ZcA3Zg/5XuGey1ZV02?=
 =?us-ascii?Q?rzkzERo7ZqK1F+RUGJBtsBOzSGdNZBJKkUS7NxvduE+fNZR7GPaOYaB2hWpw?=
 =?us-ascii?Q?x3Wb7EDP5Yq7rzms9eC3Atx/ctsOTMMpfQraJ4mc/DXPIi3c42Gx0GoaBhDm?=
 =?us-ascii?Q?M8qoP+2QtFgQNn/xYOJvc+GX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e9072b-63cd-4489-6d38-08d92ac60f65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:40.1371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMFROux2b3zewrzjKVnv86YEDcFWORM7WBsGwFjp9cI1Z1urAP6hnI8fpUQjPNl3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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

The I2C address is kept as a 16-bit quantity in
the kernel. The I2C_TAR::I2C_TAR field is 10-bit
wide.

Fix the width of the I2C address for Vega20 from 8
bits to 16 bits to accommodate the full spectrum
of I2C address space.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index e403ba556e5590..65035256756679 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -111,12 +111,15 @@ static void smu_v11_0_i2c_set_clock(struct i2c_adapter *control)
 	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_SDA_HOLD, 20);
 }
 
-static void smu_v11_0_i2c_set_address(struct i2c_adapter *control, uint8_t address)
+static void smu_v11_0_i2c_set_address(struct i2c_adapter *control, u16 address)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
-	/* We take 7-bit addresses raw */
-	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_TAR, (address & 0xFF));
+	/* The IC_TAR::IC_TAR field is 10-bits wide.
+	 * It takes a 7-bit or 10-bit addresses as an address,
+	 * i.e. no read/write bit--no wire format, just the address.
+	 */
+	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_TAR, address & 0x3FF);
 }
 
 static uint32_t smu_v11_0_i2c_poll_tx_status(struct i2c_adapter *control)
@@ -215,8 +218,8 @@ static uint32_t smu_v11_0_i2c_poll_rx_status(struct i2c_adapter *control)
  * Returns 0 on success or error.
  */
 static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
-				  uint8_t address, uint8_t *data,
-				  uint32_t numbytes, uint32_t i2c_flag)
+				       u16 address, u8 *data,
+				       u32 numbytes, u32 i2c_flag)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	uint32_t bytes_sent, reg, ret = 0;
@@ -225,7 +228,7 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 	bytes_sent = 0;
 
 	DRM_DEBUG_DRIVER("I2C_Transmit(), address = %x, bytes = %d , data: ",
-		 (uint16_t)address, numbytes);
+			 address, numbytes);
 
 	if (drm_debug_enabled(DRM_UT_DRIVER)) {
 		print_hex_dump(KERN_INFO, "data: ", DUMP_PREFIX_NONE,
@@ -318,8 +321,8 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
  * Returns 0 on success or error.
  */
 static uint32_t smu_v11_0_i2c_receive(struct i2c_adapter *control,
-				 uint8_t address, uint8_t *data,
-				 uint32_t numbytes, uint8_t i2c_flag)
+				      u16 address, u8 *data,
+				      u32 numbytes, u32 i2c_flag)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	uint32_t bytes_received, ret = I2C_OK;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
