Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583DDC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 10:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E873D65266
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 10:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E873D65266
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27856E2D5;
	Tue,  9 Mar 2021 10:33:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 782F96E2D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 10:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJfsRjKO3YaHOp+TAHqbfVLvHbK+H87Gg7y6n9tVdETbrrbfRjYeJS+ig1ODYipo8PFNAhA3msCQUa1Z2mK8g8Wg1EmcS2hBiE2kyukjHcz/40ytwAMNFrRUtNegr69YXy4HUFIMQHfQb2JRMTYpKuppVtzPKGof8siU+OttgFPT+KEVlnWy/Oqnd2Q/wtE+2mO5omiA1IauoxGVmc5b9S3i6mu2B9ZYMUahfwEky4n6dhCgfYsRjbWEBFtdc/tGort3Gq9iLUJNe//mBbKBe36FkSDh308xeH8+8M/nt5vTeLO2K6B981ihP35hSCqEkE4nD7erkxx9X0NqW3btOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EpWbdd+6ZDYCBF350AZl/i21RxXzFQsIaWOrABOPFA=;
 b=EJ9htIIhvCYt2q6Eelslt8ZiS9bp9k1O7sEsaKgD9a4sT8MZax6O+diZCYRX39pmJsH4sUNocgYlpM/HP7AqPqeYCjvhDQhYRO3ccbpsZzDR314BQOtm9KRyn8tqrKRh3RHO+pFuNlFBVqW/QaKIIwP5ZzTVY2vaUmspzd4aD2q5UXH1FUPWR7XUJ5edDZEBQcENJPEUrqESa90dBubg4ifxwYg0VCIDTUoR/4s3izTXdEKN+NVYF4loYvev55JjgsB032au5tlT5UqDiWg0C3xe5i/mfTkYcFuaQxcL4nuenDJuow+nBPC/G5Os+RKip93WrppW9gmlcsBH7azjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EpWbdd+6ZDYCBF350AZl/i21RxXzFQsIaWOrABOPFA=;
 b=IZcKwRGz3UYzAXSPsNhY5h5/HWPRl+ecrrK4d4Ehr6Nc5RvnP/G6UkAPwtYxJKUfxaaVZYYGTTrcP6yEPdTUVfHh4CSAveYlgX8eYYB1Xilti6H90/gykxydiOnL2efLKbHpEyHvdwBnKWjuWynXT4b1LeqrjgnND5TgB9pd+0Y=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3866.namprd12.prod.outlook.com (2603:10b6:5:1c6::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.18; Tue, 9 Mar 2021 10:33:02 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 10:33:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: add psp RAP L0 check support"
Thread-Topic: [PATCH] Revert "drm/amdgpu: add psp RAP L0 check support"
Thread-Index: AQHXFM9/tDtGWKjZgkauE9xBnIB8iqp7dW2Q
Date: Tue, 9 Mar 2021 10:33:01 +0000
Message-ID: <DM6PR12MB407530E5FAEADCEC047D7E7CFC929@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210309103203.43483-1-kevin1.wang@amd.com>
In-Reply-To: <20210309103203.43483-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-09T10:33:00Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dad4940e-6597-4453-9eab-0151b7f523a8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da00ee4b-5853-4a6e-c19c-08d8e2e6b76a
x-ms-traffictypediagnostic: DM6PR12MB3866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3866BB26F01D4D45F3AB365EFC929@DM6PR12MB3866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:215;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/z1JZvHeo69bA1liFdq9bpK3h2U6lNJDd4rKz7XlW8SvD53wgdh7/4ONnyP6dzjeUbRrJTr/7If77397W5bztecXmsalLv1SfkzsM6WDF85MiNZQsd8t7zM+YHLzqF8e55cDxQ+xT4tEQJayaz7y97+c6AYSOWbAD0S5hrkUzIBP+kh47BD+Nk9DovJrNeFf8amKJwVG6xY+VEp/OCUBGeZZClGtIPoWyRJnlYUkAvFLTxkKlw51Si1O3mYZukoHtfBLvhxO/P7aR5rq1I9sI9ctUDdZId8uyyHDPp3nTdBmWyTQvCDDLWrgyuAoUwgqhEvVmJ8UfpnM2a0mF1DmdN1eBtxTdhtbGjhIRDdNV8WxM4mvg6WrQhpMOlCLabDr8OjAKGpuQctlAqIqZ3kQg21Rg7TsZADAEuK30uLPPpi/VLy+nrAKc1503Dt+kEjFiCYwFI6+xC62nHM036rqBZUX9IQNjpS8IAtXbLuDA/BGIH56sG+VOkEo+S1cDdQuZBfB8rcIIn71FiCsqI/tQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(86362001)(52536014)(8676002)(186003)(2906002)(26005)(66476007)(66556008)(71200400001)(9686003)(83380400001)(478600001)(110136005)(66446008)(55016002)(76116006)(64756008)(66946007)(6506007)(33656002)(8936002)(7696005)(53546011)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9lRTp/FZ0G+Iah79gTeGWWy7LiTCM8l8jnaFJfdvcCEJfKN8DH4ha+b3ZVqh?=
 =?us-ascii?Q?6NRDTgfjuIwIUReLMwVwuUS+bntBVpN/5K0EK3gvSZIsifP3qS/KcBb+Zpdw?=
 =?us-ascii?Q?Cg8BWV52/ihJbEIr5DW5KKkWVNNWyoRyx7tANide+kDyxjZ1o7p3bcVoiZDm?=
 =?us-ascii?Q?rR2M6Ov3tO2Jxi2uRfYamOsJzxd8Yu/nAxoAUl2CJeyznRjJAD1VfXQGtNMw?=
 =?us-ascii?Q?bUnYxK9nkeUEulJKC3tKsF7x8MlwykMqtu/8hP7BdhRPOGRZEvFEyxDCnr14?=
 =?us-ascii?Q?AE2ldPrlcwfdmboyjfkSIm+dp+bwjhlO7ab+LK2LMPMUFgSKctjg4DSnXO7M?=
 =?us-ascii?Q?AD2o+oiyE89IXuKT9/Ptp5TMx7AcnKPxIqOOIq3PljrWCn3WtRTEzhmCxbS1?=
 =?us-ascii?Q?hyINcqbcJv6epimYNpLcRFHGbrZFnVlrdx0AUuOxeUXbYizCrHzFirnR9Itq?=
 =?us-ascii?Q?QbJbke3sCv2rfcILCqljNK2SDaYzwMB6NzkEDT3od8bx5jR9nOP4RpMQ2wOC?=
 =?us-ascii?Q?LDe3FGdk4IKXHyI+lVIqlqmdqID1XJpEfzmNOqBUvfW5DVgveu6eByCMacNT?=
 =?us-ascii?Q?8evrmoxFUXQQiFJzn+WplwWvhw4qxNXb6l7KBbtoTUymJ0K7HdFPGF6lqSjo?=
 =?us-ascii?Q?GLa7XeyHaGRnpFaSTx1MVY6OAXrR47jdF3ZWcsqyAfmFfaZN9Ctg1GeHFjbM?=
 =?us-ascii?Q?ZANi/gF1ccwypLqgiKCrpi32V88vee4VAePuzNK+Fl0/jg4UgNQGas7qfg6P?=
 =?us-ascii?Q?ksRau09WCfX4ZIb0iehpF9GPuxKjwlUYEFmyayDoXnFFkK9bHcwnPjwJgne4?=
 =?us-ascii?Q?QT+5NIJX5BI7mWRbxNJ5rO/pFAiN36xLmHj4e7tQHFu0xuk7GiQ0cuSZwYrT?=
 =?us-ascii?Q?gpb7P0WmdWAiQ9/ZWcDQdv/R8dI55g7JJE4pnMLrZ0UFV0z/c/gnptWckvZX?=
 =?us-ascii?Q?BUw8/mV0+ZqMyxF6hS5QFeBEOxR4NvzNIuPq+ucF6dA06VSRCh/AwiuDxFf1?=
 =?us-ascii?Q?OH2Rtlp31KZpRhLYWYAoSqyXsp9WM/3UWsaCsJuXHbonJ4swOGpI5PGIdcHG?=
 =?us-ascii?Q?jQTUr7SMn63C2OPqjJEOm6YZPLqFYiu/sPoBOgRiLe6opjNwGf9NWvRi8kO1?=
 =?us-ascii?Q?DKfuTZsj533sVQrNoc1XLQX80vKUa7YESrlajT1GCyQOJLSJwqoqIgRq2AX8?=
 =?us-ascii?Q?NxT79ZOifJryzUqf8weq4j4TNvmvUTT5oA6b72Jc7GaAkpudJ0ywgNeUEw6I?=
 =?us-ascii?Q?8pM8498aTWevlEE2kxmTuzEwJUwZZnjI9rtAu34KokucKZ0yKtdGRfgqDozQ?=
 =?us-ascii?Q?NmLlwsm3qIJ+ZPP6SC2BuGix?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da00ee4b-5853-4a6e-c19c-08d8e2e6b76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 10:33:01.9083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRH3ZQx1v/fB1XPjEq6yRvDMUHp3sQ1XetCRlCMyuP8FLQRfMfPemea1Z8iNi1XgLbYpjSm4KfcdnsQusou2IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Tuesday, March 9, 2021 18:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: add psp RAP L0 check support"

This reverts commit a77e3752c319e479c538a84c3b0f6d87f6fa4bc7.

Disable PSP RAP L0 self test until to RAP feature ready.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d9856cae9a39..80a4dc51951e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2365,7 +2365,6 @@ static int psp_hw_init(void *handle)  {
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	enum ta_rap_status status = TA_RAP_STATUS__SUCCESS;
 
 	mutex_lock(&adev->firmware.mutex);
 	/*
@@ -2383,14 +2382,7 @@ static int psp_hw_init(void *handle)
 	}
 
 	mutex_unlock(&adev->firmware.mutex);
-
-	ret = psp_rap_invoke(&adev->psp, TA_CMD_RAP__VALIDATE_L0, &status);
-	if (ret || status != TA_RAP_STATUS__SUCCESS) {
-		dev_err(adev->dev, "RAP: (%d) Failed to Invoke Validate L0, status %d\n",
-			ret, status);
-	}
-
-	return ret;
+	return 0;
 
 failed:
 	adev->firmware.load_type = AMDGPU_FW_LOAD_DIRECT;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
