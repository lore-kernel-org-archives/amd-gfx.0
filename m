Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A3C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 05:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993B964E04
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 05:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993B964E04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222B96E1B3;
	Mon,  1 Mar 2021 05:23:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99306E1B3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 05:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+G/jtVK4bFgzyoP+ciT4o83diH7sDvj6d+mgRbUhjotQshZhpsu33of7ouo8RIVfhT+lNeMiyygGfn8pDYkFz840akUJVLYIMr5UH0I5NNaNtbWjZgMCEQ7pRLBhGK/srdinwRqYyoUVeM5FXqiNugWScVsTgXJgE87BEy3m+Z0hOFhvhuTmIhvpYU94GsZvfbR/SWgEc1RYG3a8YuUZ7vPoFtVibg6WPsVIDGS/bJZwmc2lYJbkAgR528+/bnTbvpnM56kzuY2D9XzX57pY+XWO8EPmck912cYQA98fwhEDrELATjKUHoRFZ8+QA+vCK4FevIAMVbqgRF1f/PrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LUc76tKXa+j8uJPVXDiJW9GqdC8rlgww68kEXjxJJg=;
 b=Zg9GZTQEBY2lTbRxiDhDrVC6VkI261k0MnKsRWiPRDYJkd6gSQQ7b00N1+OCipjJIdRKiCKdxkn5MqQXABwyLrop48Wj9HMdokEe+T1COfN2ThUqo2CB/niBK9LTE0IK4FlCUQ+Fxw+Y2cpO0xdrjTd1w3pDTweeNK0MtFhXk+Ehn1FYOkAxcc+HgZ/BN55XdH1MnKNd0mkDpDnmNBO9FZgf3Az8w0kpiHBBuNX3A1upnbH2/q+u0kPeAj0FMUKU0LWqk+ijGTgSaX6U2cl+D2taoCuBDDx29DC188IrCdPNOymK2rr8oSV3SkrWdVsmRGQ1dYTdGPi3UNjb/yLzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LUc76tKXa+j8uJPVXDiJW9GqdC8rlgww68kEXjxJJg=;
 b=cq3LoDvEwEmh7CBLeKUx60kK+9quCRjheZyY1fWmFiMpz4/XxG87cB1oxFNYisXPQ1wdOqJfJmE3hqsz71lhFbDtoSjd574iMcb+bdKOGA+ed5HX4YY1dH16tSk88fv/HAYrlsfHDAhpWVfrTsyM/KaDLfBpnuHtaRWfQLWWBdk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2796.namprd12.prod.outlook.com (2603:10b6:5:50::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Mon, 1 Mar 2021 05:23:52 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 05:23:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct TA RAP firmware information print
 error
Thread-Topic: [PATCH] drm/amdgpu: correct TA RAP firmware information print
 error
Thread-Index: AQHXDkXj0wgc182Hs0yzw+RPVpQQM6pumLUw
Date: Mon, 1 Mar 2021 05:23:52 +0000
Message-ID: <DM6PR12MB40750ED41BBCC62F237BAB66FC9A9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210301025130.17402-1-kevin1.wang@amd.com>
In-Reply-To: <20210301025130.17402-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-01T05:23:50Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0b79217b-8730-4ec8-b3a3-864f6ef75731;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a406fa2a-c258-424f-db9e-08d8dc72338e
x-ms-traffictypediagnostic: DM6PR12MB2796:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27969B58C5FA85974902105CFC9A9@DM6PR12MB2796.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bx0HJFSgQS0Gc/1+aNz9rja/KnRrlCJbmfVSfnzXC6tDY/1gLCg8XCT2SgAeRx0Gt2oqiin+v30EVG4StRh5qCEb0Bt9P7BxecL4PsOtiq69q8QTmdz1gjYz1Gz6S+8s8oxI+FaPymmusVHe1kQMTK6GiIq74GfbiqzoEQksWnKhFGq7mjoT/pVz2+VQqM+4dDKpJQSl+CtURPgvrA1WNLv/3ioXuU8OcCz2mXFfhq3TgIkEyzvp8ViZheSjHLOqsqDZa/FwZ4wqYSr8nXp/C8TZf9K5RK6j52lIPKiuWGzLPud9hM3U0+nqgy4TQcxdKSYW1RECTwTOhCwgHYmnDNwmkB/toDBCJMwWI5BcrlwyO+fgXgRiKV9EkYWcyNVkquhyV8nQLYGbuvC9PAdnCRx1/3kE5rYoJJyKP56YLC9Hn2DtABt8kTaSAosxJrn4rpKUKdXmHISXfzkfQfSTgvOd0fJciXJUCBpyHRWM8ky35pzc9g7Tsz18zbu222t+oqPgX+6CWVlgei9POCuBFwgb2ElWDpS0CnotnHoYcw0OwqbM7quNBZy2cRSiznRw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(26005)(9686003)(66556008)(55016002)(7696005)(8676002)(64756008)(52536014)(66476007)(86362001)(54906003)(66946007)(76116006)(6506007)(2906002)(66446008)(4326008)(5660300002)(966005)(71200400001)(83380400001)(53546011)(33656002)(8936002)(186003)(110136005)(478600001)(45080400002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ljS662T/QTBQyDW4dDJCKiKlJLUHTu3Ei8iHa7OGAYzqn9jL/TzmTAu0Mglr?=
 =?us-ascii?Q?pDKUjBlJk7X5bSkhxZ3/NABt4znxB6MXxEDiQMdg2s/Iz3PV20vx4NOotOXc?=
 =?us-ascii?Q?E2Ws+UIifyDKwHBSDipf33gh7DoKguep7d+344ClVmV1h/Uhg93K1Uos2Muo?=
 =?us-ascii?Q?/S4kJObiIE0FUZi1dJtD+0kCaR/m5UVhWTpbkOqECyznJ8795yI6P7+V7Rql?=
 =?us-ascii?Q?HVTRCI6qVkDFHfZ3A8SUvRsxQBxPexnQ1crMu7dXOCKMpYgUUx6FD+kTI8xC?=
 =?us-ascii?Q?QsLnHsoWfGUcxFhgYGBq8dGEUxDpMbCGQ93H1nwl1zu8zA4iI4JgK2Z4FoBi?=
 =?us-ascii?Q?D9TtFCKB8fK+H4+i8r1BbecwK8FA70eSIuLu6mvs+8oLVmo7KsFMa4eqd62U?=
 =?us-ascii?Q?k4drwzEE10i7w3xh2ztLST9DZFn8+0ig3G6VrL+vHO3tMK19vPVRgSo2jKnB?=
 =?us-ascii?Q?DeoGHME+8rns4qqHcI0feA9LWeqmrZTvOa4cXGo1ps1/gcA1hWhozxFBjSeO?=
 =?us-ascii?Q?a4oa6EBLZtKsQd/me7nfVqoJFIhqJw6faiFgG+s1tMCG4w/AhsAPCAnMEzIF?=
 =?us-ascii?Q?vbbiVacbjKrm9fDXKX8ELCWNmjYIgkZXQwpLBYU+Ok5OrRageWln4il+esCM?=
 =?us-ascii?Q?Bnuh5sjowwBr14021Kj9tMJpWmwDYsVURoJezikDiKyYtqM3E2cQp5RHiBRU?=
 =?us-ascii?Q?zCU6gBxxF7CedGdhCySUUBrAgd6nNnVXVwuG2gqNXat44fxi7fMAZh0z3v4M?=
 =?us-ascii?Q?ojbeqe1wX/eCPZUz5OetgWJt8ANDsHu0+K+8VaGs5o4OQdzXNtihGvdeNL5E?=
 =?us-ascii?Q?vTzglkh/olzid85nBW2/gL/cBc71VXqY3UwZ8BEW8qfb3lPCMBiOpz2FI0LQ?=
 =?us-ascii?Q?9kIn97b67Whut+9FrfbVypShNywAl5WXyg4sAx1NIhX96bIyvNATadU8y+4p?=
 =?us-ascii?Q?O+jYnqVr8mLuI4ZjJUAJZsbYYCP16Rz77pfDcGopXqS+79q5z8z/kjkgkJau?=
 =?us-ascii?Q?sZuImACcl7G9p1pVsRjFUj+1bnqaIJboWgmzJ+rPR62L7C3FTraGBpCQ2Z5e?=
 =?us-ascii?Q?WMsm+KHCXWCWGYVdRNzSfhTbt2Jhp63VvBZmq+96Sqll5KXbrEWHbyfkgA5i?=
 =?us-ascii?Q?urVooc2X9RFjC91O/1L2AbswIlU1TbX639AE7u9KmnQLXWKq+yjOt+GZnsJ9?=
 =?us-ascii?Q?zeofQk639QfuT/eOkIAkM61aTEngEh+5VtQQ7lssXLI99fCPp2RhOAu8Gk3G?=
 =?us-ascii?Q?KA7b0i413jOBc3qrgwvIEeSLh6kgn3JnQifgotun29Z9J6bbwJR+LCOsw970?=
 =?us-ascii?Q?bHG7w7Xwx6s1KBjx3rJ7DkAK?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a406fa2a-c258-424f-db9e-08d8dc72338e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 05:23:52.1840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0hX33pQpbu16RE5NP4lIef2pyvuGqyeHB4G9KywziSpvKcR0xWbdO9UXFDe6yYxUrI1teNUEdqeACBPYHO1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Instead of hard code the number of TA, it would be better to leverage enum ta_fw_type definition, explicitly call out TA_TYPE for each case in both amdgpu_firmware_info and amdgpu_debugfs_firmware_info_show. 

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Monday, March 1, 2021 10:52
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: correct TA RAP firmware information print error

miss RAP TA in loop ( when i == 4)

Fix:
drm/amdgpu: add RAP TA version print in amdgpu_firmware_info

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reported-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a5ed9530f542..6c8ea9d26320 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1472,7 +1472,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 		   fw_info.feature, fw_info.ver);
 
 	query_fw.fw_type = AMDGPU_INFO_FW_TA;
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < 5; i++) {
 		query_fw.index = i;
 		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 		if (ret)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C76e6934844e14fd942ec08d8dc5d042d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637501639364874702%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ouIjHlz93nX%2Fj3gZ9tdhHxYX501bJmQm3UzqpDwSJGw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
