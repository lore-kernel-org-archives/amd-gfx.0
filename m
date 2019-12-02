Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D0C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0291C20848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0291C20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371D36E2E1;
	Mon,  2 Dec 2019 17:35:58 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720070.outbound.protection.outlook.com [40.107.72.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4551F6E2D7
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzxzUVxr2x02MFIcpHPOartk08uP05Zzr6DJMx8mmuk8qM/W6Y13JjJLtKLsk91EYAR4PSCDSr2SdXhA07K0kT8jc+TMqmwM2hb/OowLci9PtaB2qb7MvRFiLtBGpU8sd932JzD3CAYAUFdvqB7CxrGIqCBtA333OcbeZ0OXUpRqARmBZqC8TbLcfMwoNZ4S1YciVU+Ib4yGwRVAJ9/KTlNGznrCgPPJo9M99hKYcRBfTzi+rOY9ruaenjb20iRqqmZ36HxiGUal4sdx77Agq54RNBTESeav31ziRklnMThQqeXFEhcDzcF4znZeSOlhDKMy4ihiMRnMPsa1RFRqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUul85vrPaL5nxKyeWolQrtEkl5mA5WWNvAvoDExsWM=;
 b=gYyf59CDfMSGIXo6Mbvb6Kcu/rUEEPFXPXP09nZDiyYwXPKxsINDgd9BrPnmCkJA+eF9VIbR7Hl0YZ/S9R4DcVUCttTHQmQ2MuBpA8wwolSf/BR1slcInYkjpjrWeZc8d+I1tlmKdzs3btCBPnlys/SAPtsO/NHGeFQYZGymgV3hCUciQc2gH17Ni7hdMO+FArxrOvSXzV2nRWOHCtG5CfIUTJ01SEk0EvlY88s1tEBVbVGlNvtzjN763S6x5OTfNadh21nUKjYvNuF5p5iK/9ff37+Cl3OpU7EjCz+9UhsXZNGhlMUIDvNFBge1J+O6faO5OydplS7G3xDB6azYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:55 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:55 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 45/51] drm/amd/display: 3.2.62
Date: Mon,  2 Dec 2019 12:33:59 -0500
Message-Id: <20191202173405.31582-46-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f108c80b-acb0-403d-08dd-08d7774e0565
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802C2FD94DE0A96DE5B0F8982430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(4744005)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L235QWHLD8wsm9lHnHj0zkF0HutXjp3tlEFGCVwT2iZn+vQZheQhv4K5MCc1KyCrpSwFxyC/UFwG5SdEVI6FnGzQrtBlkBCMIDgcplpf3arhwOfMal62TudEXwgy54IAPA8/OcV7KYf4uIFnpqjkl8j2GOGoi4SjKZdxUh3kMYHZQx0FOR7wwd4t8l+xsUeRT9MDjGQCHq2EMYUyJzvHiV6lejh4d0UW5ohjeIx0QaKUUU498K6m8NpbIvR/cK4n+iZcsX0fx+KC5ko5+K5T9uTTlLYadaG26iPLcH/eWB/cYsAoWyUB80eHbkidc8xh9A5dlP/khgNl0ny5XgUjtPy4K47MqpSgw3LOSf6jAc4CBeGpWusFn1xwmwElEYEDk7MKGsuubWOly9jAMSBkbweiRnVps5vZ5mhGKvk0Von+Zlb6QxrIIgpSK0tNt1ED
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f108c80b-acb0-403d-08dd-08d7774e0565
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:28.1374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBXdNZGYfD/PqvM8qExY0zlXp3M+F6Cgmcy3qMJgVaYF5LakYp/dX2xJB++rKudC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUul85vrPaL5nxKyeWolQrtEkl5mA5WWNvAvoDExsWM=;
 b=39rMoWLi5WGo7YofXHB3RDr+p5X9RRAb6QDyi9bzG/+VLMMpXG1atD2D3Ou8K37BdzonYBiIuLqAqnsSV8JOyNI6o88mJqvXfWCm2UZO2mLnjmRlIiSEsoLyJiapmDNaWqP+5vEFJPCJA572ZFYagxT9ZF8A7L1f3cyO35LcbUc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: bhawanpreet.lakha@amd.com, rodrigo.siqueira@amd.com,
 Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBBcmljIEN5
ciA8YXJpYy5jeXJAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFyaWMgQ3lyIDxBcmljLkN5ckBhbWQu
Y29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCmlu
ZGV4IDRjN2EyODgyYTUxMi4uYzI0NjM5MDgwMzcxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGMuaApAQCAtMzksNyArMzksNyBAQAogI2luY2x1ZGUgImluYy9ody9kbWN1LmgiCiAjaW5j
bHVkZSAiZG1sL2Rpc3BsYXlfbW9kZV9saWIuaCIKIAotI2RlZmluZSBEQ19WRVIgIjMuMi42MSIK
KyNkZWZpbmUgRENfVkVSICIzLjIuNjIiCiAKICNkZWZpbmUgTUFYX1NVUkZBQ0VTIDMKICNkZWZp
bmUgTUFYX1BMQU5FUyA2Ci0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
