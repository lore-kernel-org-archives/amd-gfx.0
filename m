Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20775C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 05:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42D06136E
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 05:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42D06136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8D689C55;
	Tue,  1 Jun 2021 05:25:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2317889C55
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 05:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksMwRYCEq0tgWzNlSw2BbZf8NDSa9MtYBWMmgNzqkQtdxa/nvkhBYQXLv1cCkrNtgQ6LMtDkKbq3E4ITouJlgWuXtXMotTtueFwIQ4LGwP6/mFnKpslmsSv4rtMq2Yxrazw3xmvHL/LGmDI9fWbJldCiS5BQ/t7o3dc19s131dwe9NRns0+UhjlBJJilckpeDxo8/3Q4cIoMPxoz2yCY1JSKcKP3piZlL4N98CSWYHpmqAniwLGebVZP8Oi1I/1NTD5XTotxzbacf7sF/rG4wluINkOq7jcFMtOEv8/eI7os1L3/s6opaZJpCsPnCMfpQc9rbB4rm2PbNrTMBMwuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZL/vYQSc3ubbfMQFUUeza+fvx+qCKUZ2YAHa2MUlA0=;
 b=PzGgPRSeDoWBcnVfA19AU84bjHeXobHoAdt0H2fH7/zWVt3NF4zp8EuhL83O+bvmUsdQV/Ss8eE+pdmdb9u69soVlcDSSIyOndqAbdLdXqCLtF9Q6hSLd26b4uqm8SzXWIAlGUmWlD3JBiIQ2sYiNLI8JqYtmvYNpUp9yF9BTudTnDuBTiijo4uZc8fJLSpuyX+860/m8NZFfugw5x3V9HAxWCavwm31VXYVXhFThywDUE06Bb7wIfrYj8gs1+qrGRaFPPLFf2+ldoPckV0zLCxycTcrWUzYZYRqSiX1DDMNfxq1KL1r5pU1LhB57e80PWy6DAUSmtlxrEZCTrkGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZL/vYQSc3ubbfMQFUUeza+fvx+qCKUZ2YAHa2MUlA0=;
 b=AQ0SCZqyYl4jib+6doffrfToeMg/8wuUoTsdSxFC5fhGqjezapCNozvzrRnYKZ4pRNfBtbhXgd2cBcgmFZ02/gHPMDYkMtQVVpkVxldN936Bv8lTj0HCdWRxUx6xcHc0KGLg1JSXXmaUJ1lE3q89oa3Vj/5LF2nL6TGEjOh+zy0=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 05:25:08 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835%4]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 05:25:08 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Shi, Leslie" <Yuliang.Shi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>
Subject: RE: [PATCH] drm/amd/display: Fix uninitialized field when expanding
 macro MI_DCE12_MASK_SH_LIST
Thread-Topic: [PATCH] drm/amd/display: Fix uninitialized field when expanding
 macro MI_DCE12_MASK_SH_LIST
Thread-Index: AQHXVpS9ibY4F77JfUOtbQZ3NOOCU6r+nwqQ
Date: Tue, 1 Jun 2021 05:25:08 +0000
Message-ID: <CY4PR12MB12875F0D0C42CEF3A29A0AA8F13E9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210601031739.262322-1-Yuliang.Shi@amd.com>
In-Reply-To: <20210601031739.262322-1-Yuliang.Shi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-06-01T05:25:05Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7bcac0ef-71d1-4103-b93a-ebc634730982;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ead5f6-fe42-4796-8eaa-08d924bd9ef2
x-ms-traffictypediagnostic: CY4PR12MB1159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB115923B2D8E6ADF5BC2A96BEF13E9@CY4PR12MB1159.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l0WhJbDZ13SVecFgkEnypMCZGrquKExAPbeYddmYTLUSs1hn2f+HosD/wX0/86ZAhVVwjYHYUNpuJHK8MqhbaVgHhhlDEYvnvhgc/gRPkwkPpZ5ic0t8MDcup0doXMl5+tgb4q9yi/zvejcGJeJ2f47bVD56hX8Rsuc5byBRjw5P7WxPASsIByxYq/BbQoQeCCRi/tj3F7Xz15zkctKifc8t3VxJ2oyQDuZuDOt/F2Nluzl6mxLGi9h5UaAAiqS/PqA7twKuEIVI77T5F1my5BZXoSp+8GSP0j6RfXdXL+D7RJxxTYKObX2NjHkwaE9n1t+L2w9Sl7fj3InRjttlV2Qb1slSS7vBH0dYplx/dtKW3FBFdI+iOYmir2XKVkDOWzdt9sOnQC+wKw9vEzIqWeq/j0SrADLI1tZQlviGNUdp8DUCgah37LeIxCvneEfr4M5KFQ4zUc+NKNPGZuR9XFJDi1pL7y/aZV23ljRgqqMUWGrWzoNcFBE5Bq7QN3prMqZuKPOgtZ25NobTgCh1QipK+fBM1yFybfUh5SflCaZ/GSGI6EclYKmtWiOiue2UsdptUiD0gsNH+jaY/pcHcY+MMoYiaOG1pUHa1mt0GnY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(316002)(26005)(186003)(5660300002)(76116006)(71200400001)(66446008)(7696005)(66946007)(83380400001)(110136005)(38100700002)(66556008)(122000001)(9686003)(66476007)(55016002)(8936002)(53546011)(478600001)(33656002)(2906002)(6506007)(8676002)(86362001)(64756008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uslXMBnOn10oiCNmfHBtICdyoHcSqAuCPZWPDn/A/5BAb7JC2x0hiC/CtIln?=
 =?us-ascii?Q?zPEsE7fNzSZtmlQJD4WyiuoKRSGjlrborie8k26tTAyzZYRcflQ4YzSNp71K?=
 =?us-ascii?Q?Qzk2dyHqy12J0Vj9j8qcuhlI5bCC8zImivbWUXLrMqnKcUZ4L30EzIKlbDH0?=
 =?us-ascii?Q?n/Se7YL/UNKdSEn3khlX1JI+pMs3i2dl3FMjcjn/YjjrO/eOzP6z/2N9RSRN?=
 =?us-ascii?Q?ACU8pVn/tSkuGfcYHIBhO9bksuzFqa0kG9hgsUDLQ3QyRrBx+R8g40jTCN4u?=
 =?us-ascii?Q?2WUiuKJx/Dze5ek4BqtDqyZYL32AjHdRHo/aeWZZecvTAm6TSQ81IScT8W/U?=
 =?us-ascii?Q?FSyCN8Rq2+NcxvUG1TOskGSbrNPraO8reLiErtf1Vf75pNnmvL2Yc3PtetNm?=
 =?us-ascii?Q?gzOWEbN17caoYDV2KxEzvxtLEC+Z3XLTeEq8jiQ0qRYklbSe619iM8l1ptFX?=
 =?us-ascii?Q?EyukAmpPQJ9yiidIf82QyLQf0hM3OP7Q6UNwgsZJW+Zot7iKlO+D4CJ2Oo7a?=
 =?us-ascii?Q?o8neQZS19Iv0VDIIWUbwXI0hR947yIQzOcCQVQXfRlh+wiSMO2o23mUMHZ43?=
 =?us-ascii?Q?2m5EP0hU4OpJhwGfQ/5UtX/V54OSr6+JoU4vJJmr7zuUO3qMzNpu8aJdAxgA?=
 =?us-ascii?Q?x11gYQrk92Oyvw922fjsCmO9S+ZPzilJf9yGjFYp4AvgP/ezwfbt7c7QfUUl?=
 =?us-ascii?Q?Nm2SqBvDhjNbTFKXRXt2jDAOz9y6ZqdHzY2aua0c/I03Himptlm3gC8sUMUi?=
 =?us-ascii?Q?gSBovYCoxKEnFzEBrD3mFVsjfaqOKcA+Xfuj4ugTrXSUk8Ee7rNMWnOhAFQ9?=
 =?us-ascii?Q?5aok/Bq1Ih3oiTXF1kUW3iCnmzy6ag0GiT83FmHqDj0n61LXg0glioAFdML+?=
 =?us-ascii?Q?tjmlfkd33N1svrS/XAhKl/8d0MQenUo0EF4plIobi27fw1VtL1DeB958MTBF?=
 =?us-ascii?Q?W6+n0RMNFLaMr7usDDcqjGUu7esGm5OFq3/jcK7ltaXSLjwvR85OZtsa9AL3?=
 =?us-ascii?Q?QaAtnI0mkd8qkzv9mcySFdXu72v7h6+VnSIABeK5fgQKyAA3vSrutvlbbHzL?=
 =?us-ascii?Q?v8eAQx2nqrz67CIni4sxNMlvmTac/Kc+vdOfVaRnueteS8R/bqNuEdhXaJ0d?=
 =?us-ascii?Q?x3BrPxh6xrtwubRQbr9Wt6x5reGjVdlO7VMjtTcFHvUkeiKDcipMgM5xknjk?=
 =?us-ascii?Q?a7C+k01+eMv5qUylL9I6qJ65ZI5ewM3KQqxn1xr70TgJMaul4vTAEd35scJI?=
 =?us-ascii?Q?bKQSSGXznEvEFrNRh1oNvnnbogs8DfiM3akGxCDgLXcyB3cme71862hmYGVL?=
 =?us-ascii?Q?J/G6TfIXqEX4LlwOtrTy/fKX?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ead5f6-fe42-4796-8eaa-08d924bd9ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 05:25:08.2831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Zj6hLMejD566P9rE3INJxORxg+GHcq6uQXTst+Ux6aMjJhGTRHol8gs70gUfUkSwNaYcGTn6pGs/NHfqPj59w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
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

CC "Jones Lee" as the author of original patch.

Below patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Shi, Leslie <Yuliang.Shi@amd.com> 
Sent: Tuesday, June 1, 2021 11:18 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/display: Fix uninitialized field when expanding macro MI_DCE12_MASK_SH_LIST

This is caused by 63213103 "drm/amd/display/dc/dce/dce_mem_input: Remove duplicate initialisation of GRPH_CONTROL__GRPH_NUM_BANKS_{SHIFT, MASK}"

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
index 08a4c8d029d9..f98400efdd9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
@@ -297,6 +297,7 @@ struct dce_mem_input_registers {
 	MI_DCP_PTE_MASK_SH_LIST(mask_sh, )
 
 #define MI_GFX9_TILE_MASK_SH_LIST(mask_sh, blk)\
+	SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_SW_MODE, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_SE_ENABLE, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_NUM_SHADER_ENGINES, mask_sh),\
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
