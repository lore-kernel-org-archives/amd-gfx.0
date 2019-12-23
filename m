Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2EDC2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 05:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB92F206CB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 05:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h1gFbcLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB92F206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5670C6E132;
	Mon, 23 Dec 2019 05:48:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E9DF6E132
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 05:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPbc1idmR32nIufD4L81+MtYu6Sbx4vPK5ixDS33KAr11H8FiALnIUggM/wWo9dwMq7Qav8QSGGjd+Eu4BqvgE6g8RW2u0wbcSJwgdsl7/nKwKDszhwxz/ojYvjRTPvioOCM5xrzhxRR3yxHYzU9njftizx8LpCUqFu7k2bi4R83wosGPudAe4dQR8J/ONV0WvjAjdE8bs8+DN3IYD2fWxE6zEH/quYQBm0Y8ueVUkpK7HahoMkUyJi11s5Q0iKiNawHt22rhkc/Os3jXJmzJndgx6QKY6e3r3IcwStw0uTwHjU1iHRBLqkpIiP4kuYLBcIw6NgEXen7ArnFg5efAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RezupPdgXvA1yItbq6JyajTxH1/sBUkab4EVgq1QAD4=;
 b=mifWPfmADPOuzMDdI4XCR47fzZzxjknJ69QXbXezk6I7mg5vBKTOxMzWQ1+QoW3ahRjs1UcEzm6UsJ++ZDm9uvuuW2wo2RQ3FlXHNGyqGNHOTEEmsk+RNYVs/XlHrnSurfSV+gHZJXhtCV2trK7wOIUCy5S4nM49zyxHReSEt+w7ED15J6/5qn6BOIVn2UX3RwEuEeLa7g5GG58Voc3LG5utrfhDQh7o4ms8ZsvXBWtHC2zfN6IHrxFMQ+mo7TptZmBTBSaT0CqNmXpZ51rReJQt2TixecksZVnXkMumbIu8t1HIsOI/zEYxEUk/fEcdhyFqp6iyFs4PdIo4qt6rYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RezupPdgXvA1yItbq6JyajTxH1/sBUkab4EVgq1QAD4=;
 b=h1gFbcLcvnI9KK06ZtTSk1dPHr1LrwtbS+XehChQ42lKsWKPBB0UVF4LEkm7WsZe4xCyhDLbRrDtqK6wddakAuCOgRm9moMYccLRwuUY3JyTF9NCVSRgrEgkeBLfFthjzuSrSUKg1nTzo9i7qctt174MFuYmaDELquNPAhGvAnE=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2536.namprd12.prod.outlook.com (52.132.140.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.17; Mon, 23 Dec 2019 05:48:47 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::e944:3f8b:ca64:ad1b]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::e944:3f8b:ca64:ad1b%5]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 05:48:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add missed return value set for error case
Thread-Topic: [PATCH] drm/amdgpu: add missed return value set for error case
Thread-Index: AQHVuUtYZJ75Cw11qEmupbf0EWkPdafHNpbw
Date: Mon, 23 Dec 2019 05:48:47 +0000
Message-ID: <DM5PR12MB1418E6B73369AD2F3ECCABC7FC2E0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191223044151.14876-1-guchun.chen@amd.com>
In-Reply-To: <20191223044151.14876-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-23T05:48:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b054202f-cfe1-48c4-be64-000003de25e9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-23T05:48:45Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f6e4b159-d6f1-4db3-9c14-00008f56bab2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55c88c9d-041f-4958-aab8-08d7876bc77c
x-ms-traffictypediagnostic: DM5PR12MB2536:|DM5PR12MB2536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2536E72026C90FE385AFA489FC2E0@DM5PR12MB2536.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(199004)(13464003)(189003)(8936002)(81156014)(81166006)(66556008)(64756008)(71200400001)(8676002)(9686003)(7696005)(55016002)(52536014)(86362001)(66446008)(66476007)(66946007)(478600001)(316002)(186003)(53546011)(33656002)(26005)(2906002)(5660300002)(76116006)(110136005)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2536;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oWQ+GvZOB+AKw3kOFBwWYdR3IDOo4hCC7JCYk7XCX3KYisht2PfE79cglS/g46e53hhpij3PQrkh9EiRb3/OWwGoVMj2Y3arj9eTMUEYIisRABBNUq+neSEmpaqs5U1uoe833dbhYxiV1eTkQXuWkYhlqg/mxyuFHB5BO9XmcqPItu2DO8Z6/9N2Xz5SCttTsrP4FnexDZuZxpebhL5laWsBPjOGB5zk4dX6yv4MYr80hi5BUij/ZmNhny3Cq7RZ0pJR262Bnax+n4CYgZyv+GL0uzurtTeOtdw24JhGGC7gOr1SHF6lZ2uBRtmnppramu1fSsvPqJdMzEaFaPeXiKTaFySpaQJCpHIO1C5Rp+MP9VwRlLiq0f81jG+aAm8F+kucv69a0vtSmcO1Tax1UcOzA84KQZc4wU/XTgNa+MLuaWNarKh0UaU63qjwSGSEOquQPtnTryO7Lo99l/3hi6JFNa6KRnT6J6Hs7zJ2zLtW3W+J8NBVf5PghBnIOZ55
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c88c9d-041f-4958-aab8-08d7876bc77c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 05:48:47.3221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnA6CoQq3C47uVF0w4PUi4jc0V4n3fr0FgY83o1E2Wdg7CBTfeLItyGcXq79czB71vT+oxhe58Gd/89zhUk0qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2536
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, December 23, 2019 12:42
To: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: add missed return value set for error case

Return value should be set when going to error handle tag for error case, this can avoid potential invalid array access by upper caller.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3f4ba408aee0..511b137d9d5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1313,6 +1313,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 	data = con->eh_data;
 	if (!data || data->count == 0) {
 		*bps = NULL;
+		ret = -EINVAL;
 		goto out;
 	}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
