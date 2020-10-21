Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB71C561F8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 08:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF89B22249
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 08:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eb4fp/MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF89B22249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3A26EA89;
	Wed, 21 Oct 2020 08:26:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E623D6EA89
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 08:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiFXcNVvZFC938CrVg+/tPHBa4W4PgcQcBrOFA/N74rUKNMxd84cv8j7hu5msbD46ZdbwS8LtAhL//uijE8kwRfWrrxrZEgX0MuTZNGmRL9xN+xEuvautJorAs28zODl0ZS6ATevp24yVfVb9GIZraQj0PrSP9I3ixc1j4qVMo0MRRb5WuRDiSj1caTcA2TwjX4RbNi0AIBaM5t/IlYU+1XAB8WDYsKlhYUjlp1jMiGncjj3RilVc9/sgVT9bedFPkmRuMlIUsr6wmDn3LabRx6pf3AOnzgl70Den+ltwNEM84hRous44WzMik4eCMVv9g1/C91IfOEm8aM3Fh5IMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cWk1/y7tTRPX/4LxJaTiKxWyVqZf5M6JaMTLWA4Jyo=;
 b=dO+2EUM9bg6RkzDzyQcoiB3clSFuDY5Uaz0ag89OHsMwRC7CIbVbCWQtBnqQ17wRPdwXx/322wA4oUn8IO5zLCb9Z4N2yG6XOgN59TKA5kyqHJrfzCI1bptgK/5QdvhT9ebGgNthqyB+4nG+v0vC3ZFaW1OJdoKgXOzi1TCABpU7TmrZvTTsoHwuNvEa++bXlRxMlBSfcX9R6qR/2897dfXaarU0XwOi5LEptslf+tvPmdyvI1F8K6wk8gh1VddXYtl8XqMtxs9WcX0vKaZ7I5iX/AqiUVWuAreuOiTG7eVqT99C+7HTTPtD3muWUgWPNJ3+3B2xR2r4XIr1c0yiqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cWk1/y7tTRPX/4LxJaTiKxWyVqZf5M6JaMTLWA4Jyo=;
 b=eb4fp/MO4bLvZdrgXEhAayjNZonUqkFk0a7JjmYCixJXnqHLjbLcW6emKhRIld+fuDDkuqz+to7jzXioSeHLJrNFnET89ZjINwYVuaujMtfhmCqEuHIs8yNcgh7xY/0W4wcR0oaU2GN+9yulN6sgxcuTWKMWAYA0r4GGsf05OOc=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 08:26:18 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826%3]) with mapi id 15.20.3477.029; Wed, 21 Oct 2020
 08:26:18 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix pp_dpm_fclk
Thread-Topic: [PATCH] drm/amd/pm: fix pp_dpm_fclk
Thread-Index: AQHWp4LIW1m9MZX+C0KJYC5jsfQq9amhuJZg
Date: Wed, 21 Oct 2020 08:26:18 +0000
Message-ID: <MWHPR12MB1854F35F00FD8E4A01735DE3EF1C0@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20201021081833.15508-1-kenneth.feng@amd.com>
In-Reply-To: <20201021081833.15508-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-21T08:26:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a96ea2ac-015c-4c54-8b38-00002bef1bad;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-21T08:26:14Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6d1a4382-db6c-4bad-887e-0000f66faf0f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13f90cd0-3afd-4aec-5446-08d8759afc00
x-ms-traffictypediagnostic: MW3PR12MB4572:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB45726C9EA51FE287CE4D355BEF1C0@MW3PR12MB4572.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZjK6QHEUR7nnsVsc2oF51xaWbOX/335Qf4UTNO7ojQZlwS3+PvcIr+TcgXVB4M1lToz4onRhwZzYtwTq7Fu2zB72DsxUOaK6AMOph6FnuZLP7GLRii5FmYraOMZmPrfR/WyLNBSdu6JmDqOZOxnfAgI/d9ZqJEQRWmqmnONGvcgTORUivp2GLxSNuy537s2+gOBSvFyLly6KM46B/Vqe1s8qqFZJoGkC4PxzWVUVdufl83yrpCuhNwhbBtvHPXWrAv1SIcaS/2pmy1fiyQhvrrbjBLit4ukugkxYPzVBrS1MrdeZuN4+G+RZraZvdHE9FKII7dtPxqw9pq77chmWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(2906002)(4326008)(478600001)(71200400001)(8676002)(110136005)(83380400001)(7696005)(9686003)(5660300002)(76116006)(64756008)(66476007)(66556008)(186003)(66446008)(66946007)(8936002)(33656002)(86362001)(52536014)(53546011)(6506007)(316002)(55016002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cZXwXEGiPFINo8eWK4r+6tYrQtD1f39Zwd9Cr0io+dAG5u46ObISeIJ/iCeRxzCg4annLWMD0qbKh9Vkj0CzuuJ9aqolw0Z6CX+g718yGnevo81kh/9bsXCfA3s1f7dj3/ZXU+eqUD25kF1V3eGKzHalCG0gad2CdSQWl31Orz10uMnYRiLCGWAapIp0+SB0VaJVVozupyzWrk8+3AG8Gx5CCBKlhoqA/FePxXD82d8Ui/2EX8hUF7/wWFmsGbh8ScNAzzyIF6wD3R6Aoa1KHqe3s7WEErpF0cS5b/C8Bw14RAnoOLBMJAIjPi/eSerU3KiiSYJb0WNBlr2w/CZElrdKg7xGjFDXmgw+WefkV5wbzdF/3ftO2WGPNI932uNGOcJFN/Gtr9WiDGOjBqLlpgXOpgx2j8RRHoNHOM/2tJfsEnnXNdWmg43lPbcRcnFWHBPB6l+IrdynRaRk44X4RifRtqpLcqEYa0ch0hkhv1ciQUkqmArCg5idHrbBw6ooc+GcdZGldRnh9z30OSh6wvyv7wFv5VN6wOeblqQ8ZHE0ixqwFIFMQtDLTQFTdOkrzfB+UZQubZEN/vNmBgWeJo6UCmxcYQ6PxNmEKsl2cwiw6zDuZQIOlbtmBpUgECef2CzpT+ZXHStYLqs3u1Wn7w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f90cd0-3afd-4aec-5446-08d8759afc00
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 08:26:18.4769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rnBSKRL4IBm4M4QZW+EytmK1Zy2Z9PhKDIE5/x3GWIedGEBk+WzTm4VJtQTWZzX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4572
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com> 
Sent: Wednesday, October 21, 2020 4:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix pp_dpm_fclk

fclk value is missing in pp_dpm_fclk. add this to correctly show the current value.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 27b6cade9ade..d2851f8e9c11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -456,6 +456,9 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_CURR_DCEFCLK:
 		*value = metrics->CurrClock[PPCLK_DCEFCLK];
 		break;
+	case METRICS_CURR_FCLK:
+		*value = metrics->CurrClock[PPCLK_FCLK];
+		break;
 	case METRICS_AVERAGE_GFXCLK:
 		if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
 			*value = metrics->AverageGfxclkFrequencyPostDs;
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
