Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8AEC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1DA61354
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1DA61354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19A66E5B0;
	Tue, 18 May 2021 02:59:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972B56E5B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 02:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjWnDuV+RqkCgefbVC2czy0C1Pf2rRFElrZc5lgSRZYfBn6Uxlpg+p0a0NBw4sJvIrQeoBf98tKVsEuNyp2CAMrIsEDJSqFXVUecM7ieTTx9juHih+b+w79eTyx/Kal2jUC2liyAEqrQZnC141bA9UYlqPawG31l8yWfLvpzHWArwuYBKPdvHmNVa+CEn5yts1SwY+XAT/wntVHAbe9PuuRtQhUE6x3SoItOQWSah6G8F8RznqorCXHOq9t7s8wjwawxn6+cyCvf6rc8fsiYsjsbkg0Y96EEM/vN7cURlE1yKmS8GpPBRmiWPRXkiAFwFk2Fbw0+KO6RixBjndNTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZKp8b3T5LUiBMT2v0eTAAOvXEqyozizP+SgMiYdNs0=;
 b=YwtV3u6gfkQzBqAODaOGH4cTy54HllG8uIoMmbWRUhtEvUKvWZWse3YpG2v7TrEEF9OE6E1aYj75T2WPHEgELiAj+fLzM4qQ96+IsOxGA5R2Mv31Of8Y/YRmMaLpCcXfKiYRjr3rjf+gzArvMCnSc62opONiPsyYifTHJ0x7MVmEXgdb3lisi8NdszCHxGl2ILdmsnhDp0vaR/QoyHsqd5Np4Muf9FH9/fe3O8M7SCFxj/g1MRnxd5CAWfLf6IvwkhDymEK4sKfA21zzwhKXFy2PyKH1sChhC9j8WFhNRfVrx/o//Mn7Hk0hzXub/Vbk59k4gzGPiqmgIpHE+rESLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZKp8b3T5LUiBMT2v0eTAAOvXEqyozizP+SgMiYdNs0=;
 b=G2epj7AgW8/OzWuRsjrEJkw6PAXAUb/RU00tm9ZrSIJY7inViI83Pj6u045EIpIeOnJBmMno5BXsWfv/21ecivmkndgz7mXhLDXdV6izlUxqUspT+fhcasMm2i2cKRboEAgsZRL7sJH9dKaukWW6SreCaYwJmQc3WPhqeRMYU/I=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BY5PR12MB3684.namprd12.prod.outlook.com (2603:10b6:a03:1a2::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 02:58:54 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::a01f:b2a0:9723:22fb]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::a01f:b2a0:9723:22fb%7]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 02:58:54 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen, 
 Jiansong (Simon)" <Jiansong.Chen@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: update gc golden setting for Navi12
Thread-Topic: [PATCH 1/2] drm/amdgpu: update gc golden setting for Navi12
Thread-Index: AQHXS4mxwpTdHGHifECWQnbNCNF97KrojFkg
Date: Tue, 18 May 2021 02:58:54 +0000
Message-ID: <BYAPR12MB364021AA35F4CC86F1988CD28E2C9@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20210518020055.2132-1-guchun.chen@amd.com>
In-Reply-To: <20210518020055.2132-1-guchun.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-18T02:58:52Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ea084d5b-d636-4f44-85ed-852164c0d226;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a934e63b-6b1f-4e56-c2c7-08d919a8df98
x-ms-traffictypediagnostic: BY5PR12MB3684:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB368452EBCBF458C5F30F738B8E2C9@BY5PR12MB3684.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:160;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UUt7+1ntVd/Q5DafnlUAq00qrpJF3JD9ifJ/KlBa7f9wDxiPcKijGL5SWG6Hk5u/y56drL41lcQn8NE1LuHxfG9Wl6ikzr3zvz4gyOeSEKiko6B3zihmh6lLIVvCfGhiO6pB5CfC0Cup97MNaUPo4yefnHQgcCzcKE4AClP6HXrn1sT+ssvK3Zdh3+M+NqgRXoBTabq0593ZJ0cRJrj0DcNxCwP9R7WPUbOhUvYXvwmVzLD2laKkwRoMFef1sW999TdO5kaleS25u+mJ1gMBFw4Kjyy9SDzZB/0/526zFVZLMLpocT+0zL06JMiev0ufYXySJuuvRe1XFPCxC8Imr74oONh1LmDV7gzxmfbEB6NCiR8xTkH8Xx77mgpOMruJpbDU16Ol7ZxjfCrt37iiud9hqTAVTABpi+QUXnd/A2Rm4GbDThGmZd/zgETmqrOXeSrIBBm1+FdLEt5KEKLnRhNqY/siYKmg1wzDgHPcv+vTSJSYar9AIYN1uGfywSBwhAmcpITFpQ7KItMsndEbK4Id86f7HjHBo1a73DA3F/kizDIwKRQLtank3AIRoou1pvPQzzpXijpfzHv/y/XqUJuts2X0ZEMqBfjsCA2Y++S49IT3d8fh2aUImXp/c2VseewKBXjxFfsz07j/BitD6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(9686003)(7696005)(478600001)(2906002)(55016002)(38100700002)(122000001)(316002)(66946007)(66556008)(33656002)(15650500001)(8676002)(64756008)(66446008)(76116006)(66476007)(6636002)(26005)(71200400001)(86362001)(53546011)(110136005)(6506007)(52536014)(5660300002)(83380400001)(921005)(186003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TOFw/oVluFyYR9vQUtkoHpnOREW+LOZa6E87oLxiOAKm4JVjUObz2qbRM3U+?=
 =?us-ascii?Q?XNykW5VqDb4GQW0XrrFJPOxNr0FYDzwLgRoJdiGq0nTPUOxJjKQ5c2CFn1jj?=
 =?us-ascii?Q?ULbkNVr41dcYB2OTsy1tWdGVrhrHQiFyBN3eYEzcyW1rksmbc6xXtsnmliTL?=
 =?us-ascii?Q?w01UNTvMPlN/H7+KmQ601M6fwMoGWqEEeN/aS3slowHFAvZbUsmKK4Bq7Gn8?=
 =?us-ascii?Q?Ayq0kKinXhCavg0w/TOnLIuFN/jbaWHbqwq6LCnb06FtPJ3nUih3kXPpRa48?=
 =?us-ascii?Q?3pb850uQZWboxo3R26q9Dt1BItkinxV5z61e3RQVlvJADKGka6dOLA7yo83S?=
 =?us-ascii?Q?gsuHAYo69VMe2HVV75N7PLmkFvWMwKxKZmqscfL2EE3O4/UKAHGbq9oLFo3L?=
 =?us-ascii?Q?FR1vVlYyhkmaHo224xY4b2DlvtTIyDeZF1fUDaPqDRLSn6l1FyAchmeSMK8I?=
 =?us-ascii?Q?3iKyzGJUNefE6e6+24S3rfGC6DpORhJpM+okjHbBGsIQvzP9yOXQMDoYgbpm?=
 =?us-ascii?Q?xvKV5BDwjSvVoWESRPD8+7On2W4vmoKuQGdY3GiEWZ2JMVfl2L79uEr4kt+w?=
 =?us-ascii?Q?Sh1xktOUJB0EUhw4UErP/j8mtJvQG8ho3Ar/U2Eg6LGc88EsxeSWhR0+E+Oq?=
 =?us-ascii?Q?TcoLsbp66884oqs9z8A91A3kORmBW8A6/kRp4d67uWAmRuS/WYJOusbT2f+W?=
 =?us-ascii?Q?qfMM3P3pIKCP/bac0LIWyd71eGvkOhCFu2Mw2tKl6NYtjxVi4LnvuX4tGvJ2?=
 =?us-ascii?Q?gCrnXkdhcayDIQ88JRE+LP8VrBdQWEGNiGj1t96Yf59tpLLM9vOKD1kTwNVy?=
 =?us-ascii?Q?fLMEaN1JLWxGMKZChCSmryV1qakZZlFwKUOYqthBVp84S+KwDIuHtko4lq8O?=
 =?us-ascii?Q?qR/vwHDiWKGt5qd6EFdI+cd20UCwJ7yb/GrXpQQi+4u9bEyM02CEM1zkGd1t?=
 =?us-ascii?Q?jOCG7IPXP+uTSgqTennk+dKzzV8GEZbrYc3hTjN2ReC2oAXZDKyY8OJIO+D6?=
 =?us-ascii?Q?TUgg0n/iu2DJz8JnujxHhhmf++W9flJVbewXvnJtL9B35srcOQlsOKGK2pGo?=
 =?us-ascii?Q?zax4qYPKjsjVuR5gUD1bdvh7EU3I6617CjXQLkToUr26r+/26xY17tMxUrr4?=
 =?us-ascii?Q?fGXfwKj8sc32c5rJcsw+MQERTJkgRU8VnhmwQFmo6oILwm33hKdN/igOFyhZ?=
 =?us-ascii?Q?Mq2C01n+v49+Se7G3KIJspLVv12MVzNNou5gc9N95NX7NSBa1QlwVPA9pWud?=
 =?us-ascii?Q?UCWZz/NZww4rpQUOKkwVcTDaZdVNPTsftGVTk3B49vI+pfxZ+HsrzmeGQPAH?=
 =?us-ascii?Q?jXIhCP0QlcQbzUMv6LPfMg0S?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a934e63b-6b1f-4e56-c2c7-08d919a8df98
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 02:58:54.3947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxaMd4ewMophnpoj5xMV+NnKmVU15tQtzfCljRkcg15Jhl28mRPhBZsxgRYeDi1g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3684
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

[AMD Official Use Only]

Series are Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, May 18, 2021 10:01 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update gc golden setting for Navi12

Current golden setting is out of date.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2a3427e5020f..7edd0c0eed8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1399,9 +1399,10 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG, 0xffffffff, 0x20000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG2, 0xffffffff, 0x00000420),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000200),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x04800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x04900000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DFSM_TILES_IN_FLIGHT, 0x0000ffff, 0x0000003f),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_LAST_OF_BURST_CONFIG, 0xffffffff, 0x03860204),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1800ff, 
+0x00000044),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff0ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PRIV_CONTROL, 0x00007fff, 0x000001fe),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0xffffffff, 0xe4e4e4e4), @@ -1419,12 +1420,13 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000820, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1, 0x001f0000, 
+0x00070104),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000133, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0xffdf80ff, 0x479c0010),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00800000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00c00000)
 };
 
 static bool gfx_v10_is_rlcg_rw(struct amdgpu_device *adev, u32 offset, uint32_t *flag, bool write)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
