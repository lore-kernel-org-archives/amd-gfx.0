Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA6C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 06:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD3D60F92
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 06:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AD3D60F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30C26E8E1;
	Fri, 27 Aug 2021 06:46:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6C16E8E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 06:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAjwu8i6GebkFUKH+zcE+D2ndLRqvM2hZZOE3T0QXC9g5R7Rm/2U4mBbUeVriNWjpPsHWqloZLlrkqdVk2YxD3cZitG2U7zNKh+JFDfljPeikx9uxKFp5+VFijM+xKfr+htxN5CNtX9xw9xlcrNmLgbK/saAKz4wrv2GMfaWcZY9QD+jRuqgXUrUKTqI+GfvIIJnQOsPNYgeyFstBiNyHcHXIKW4wckkR1/KStCDAUmzPwX3Ezgejocu1xdzY6eeZjliAKdYltU5FImQMk/e7k7Z0nqfZQjcyztYYOhB8ja0cpgvpTQitu0zSywW/b1fgBlJZUpL6xEBEuLxfIcrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRECFU6EtN/GFCZHNrBt+Gaj03VSjRFSnnTtfuCduvQ=;
 b=bqz8gAOAKJrlgJLVmF9geiICOJJhEuvlkHrJwNaSJquS1hQ2pfw/D7a7oAh9BUewTvCo4Qw0eaGQgihKTTcamuJ7B7tYXUVJC2pideWZpiNfEHCY4gb5CSdP+iPA+jwpUsW/kGRnDZnScccyA6AdZRjD2UC9aMOoDCw4/6V5Qo+kVwWaKchScMC2d4GUU/5oeO+9Bhe5HmSejvdu20njQZloDp0adzW2Lew1myMe4ftVqweV7SHr3c/YtHu0EGQuvai2hm32DHH5VpgGAq/vvmjgMySSTUZ0RcCJfpzbdhxqCmfJXzjkLqKv+Qj6eZAP2qmf2IXT+OcTXH8ZgBZKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRECFU6EtN/GFCZHNrBt+Gaj03VSjRFSnnTtfuCduvQ=;
 b=3jRLp8RRxmFvtfWaWiPRDF8BUaUOw+5U4EZAwaW6MSymcs8X1ofOf6GnSrx8a87yM3XBvb7QKDr3lqrQyuEigKIp/7lWsNdd2iLnE2N/gkFxuFkWL4fk+L15zQxU747WwthHCqppcCOPti96OO2z6fDRqFT7jlG7eM0w9ZTivKU=
Received: from CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 06:46:34 +0000
Received: from CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::64b3:54c8:3a3b:5d09]) by CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::64b3:54c8:3a3b:5d09%5]) with mapi id 15.20.4457.023; Fri, 27 Aug 2021
 06:46:34 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>
CC: "Yu, Lang" <Lang.Yu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: show both cmd id and name when psp cmd failed
Thread-Topic: [PATCH] drm/amdgpu: show both cmd id and name when psp cmd failed
Thread-Index: AQHXmwZRa0D3psNqmEmS/55yEXd+uauG6G7g
Date: Fri, 27 Aug 2021 06:46:33 +0000
Message-ID: <CO6PR12MB54126F58A08B5BA11C056D96ECC89@CO6PR12MB5412.namprd12.prod.outlook.com>
References: <20210827054128.1136846-1-lang.yu@amd.com>
In-Reply-To: <20210827054128.1136846-1-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08623b7e-090a-4fcf-c577-08d96926690e
x-ms-traffictypediagnostic: CO6PR12MB5425:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB54257965D7F090052D64B242ECC89@CO6PR12MB5425.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Z9QD2yYhvfpOhN1HfvaoZQ6JqtINjhpAb43w+IjhIoYkRk4bBqcHt7vpcS0LUYRJ9BiwFIquRSKCcsVQ7X+rMb8pUVd+axDkDCYEVmunv/TI0+pVM7iEbPWowCAIu0qFwhTHLfpxqXdFtwmmi47gdm9DiECeF56ahY+4q73d6Zu1zVjqhVNRhVW2Rf1qVzVJC8IDMqnLagLi6/p+9TcAZzqv95MA1JjE9WsXFHvwsP6Z7aS81vM/aKYpTgjrPcjWmoHTw0iiTxntEqSS6iwK9ftBfuOFpo6TxxdfXkeYhvNRJirij80FQ9t476U+Jl0fTlfBi4jEN33HYAjskeEw26rnEBG/Cc/RFp1s7t0+btbksoLcAeDzZWQtnDWiQZLO55QPsT9XaoxFR/k0AIg8lf8Z74upXa14R5xyHaiXgFpjw2Ko0kNa1HvACyNNpREdN7/SAvGfcv6rpnyHA+KM4ScTLWopRH2Hykddae8a0HzOwsORIjgoGSkRUIf/5FXl6KSCgqUdSLDBMVeRH3nSUU5sBa9hzjf2Zoz7SdtsZyAh95MNikxGLO6P00vODBFLO8fwiO7XHyzaABcL5ZgLeDzLwE2AafMWgqqXAg8bVjmye2AsLY+O6ZzZx1l6hLt1gS1lfGK9jBbYDH++4ATV8qZ28mRhAgbnOXjvWnuXewfSf7zqK8+SuxE2kxRaWe18z3EgWliEhdEUCgli3ybiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(64756008)(66946007)(9686003)(71200400001)(508600001)(7696005)(8676002)(6506007)(33656002)(76116006)(38100700002)(5660300002)(4326008)(86362001)(8936002)(66556008)(83380400001)(316002)(186003)(66446008)(38070700005)(52536014)(66476007)(6636002)(55016002)(122000001)(53546011)(26005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OE1MfDAwGx/Vesezd+BoC88GII0UmdzPHOQyajr0XOS/irFeNrbiM56AM17U?=
 =?us-ascii?Q?YitX1rJkrHFj5f5KjWzL5nEHgkkmoF5+DXmaYNiMq9tBaSkVtKTs/fSNOp0j?=
 =?us-ascii?Q?ZytAalJcfT2JF2h3OvtyD16TseLVhU1q0ExJ/7FXdWAY+cPEx80CZ57upDjb?=
 =?us-ascii?Q?1rLmVZHuKMPpm/mYquXzxapsR+SjX3e0usDknUNy9Of9/SvWSyC28/OQTLnR?=
 =?us-ascii?Q?9sDoMVY3gc0VJOHP3T0BpC6rcc4Oxy0Hh5YvFz7glfwCTiFiJaVgu57B4GCj?=
 =?us-ascii?Q?2JU1Es8u/6xiu+RHUeZP6e+YVJsW1P9jpDX8+6qIM7Tji7CuXFnXc0it/Xkl?=
 =?us-ascii?Q?4d1oPAg0VNOxSlcvBQS82Qbh75EPZZ8JlcPm4EdTQToD5u/TlUigfnSS52lH?=
 =?us-ascii?Q?2Y6Bwh9OXGGC6tfagYVkoGfLG4Wqevc4j0NybMh04quRz2iziSVH3/nddGLM?=
 =?us-ascii?Q?xGjBN9gSh4vsbeZ6Z+a6EuLnFpFyAEbjzu8vfBYMU4ziA7/CKrdtkVH4VsYU?=
 =?us-ascii?Q?BI+U2odBhC4F3NRCb2nKvfZRS5ubdc7EyfXsMHA6RKmQpH0RaxaYmF2//HhP?=
 =?us-ascii?Q?Qrv+ufs+wjmfS/vWOcxFyl2xOW0LjyxKMT9qu8NP9VysT4vUMLsPIgLu2egt?=
 =?us-ascii?Q?oiK67JbH7Q7NultVWYDE6QFhM85vvRhaiit3WCvtRR3YpL+rtXkYrsnX7FpC?=
 =?us-ascii?Q?kxiK9xX7VkdFR75fXYyi4xGCUzSJU2HoNQg5CsXKHCqmTHaDXVJa2NIb0Pyz?=
 =?us-ascii?Q?6QGJLHQbH6id41hQeZEyWgMXZ67ZkFV074YomYTooEX3DkshVfcGTqmMmiNx?=
 =?us-ascii?Q?B+R6K4iDBAEKbeuY3yzoSZA8tHjWj4gWdjoc7MNto25n2Kme8j9DL7+DwL1k?=
 =?us-ascii?Q?5X9RZBI+Eegu8FntFGBRnp8mBpMO/ezeoaTHHqMeXdjgh4p39yCXCJjJekzi?=
 =?us-ascii?Q?zGRVVN7nY3ll9ooLD5PUgMVtoMosfUX/8o/o6TnLRyCKdsMam89tGqzF+mHn?=
 =?us-ascii?Q?FWL7ddoozFDIwgTT3KNRu0hVYeqqb2fNsLHwYxefVLtpZz1roMv8dakbQfWy?=
 =?us-ascii?Q?2f3d4ejkuXGsi87VVFbs1cznNy8fMrwztqBrsI9EzpGhgdjbCJ0cHvUcCAiT?=
 =?us-ascii?Q?I0w5QLAhBAvQ6OLT9FZlNIOC3erSmmHa/FwO7Ag/JHI0Hvuwg8wMoe2t/jfW?=
 =?us-ascii?Q?4FBohkX/Ta7z6xlbNCoAfp8UAQ+jJAU8TNaMsa3PN7VJPVI0s/R7SsDu7IV7?=
 =?us-ascii?Q?rmyHh/5RiJ0mQP0LdRpmFpVG6yPKFqoMHkuEEFIYTAdmq11YiqJ6+2qHSI6O?=
 =?us-ascii?Q?Vw+v0uVAKNbDkfVhIuwRSDrE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08623b7e-090a-4fcf-c577-08d96926690e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 06:46:33.9764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/n3d9RNZ2nwD0M/QRADpx1Csf7xbQuMVUrzh9ckN4/5xbvRh9GdFWs0ISHj6nffI7Xnwk487DgqLZ5UvlRFdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang Yu
Sent: Friday, August 27, 2021 1:41 PM
To: amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: show both cmd id and name when psp cmd failed

To cover the corner case that people want to know the ID
of an UNKNOWN CMD.

Suggested-by: John Clements <john.clements@amd.com>
Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 23efdc672502..9b41cb8c3de5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -469,10 +469,10 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	 */
 	if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && !ra=
s_intr) {
 		if (ucode)
-			DRM_WARN("failed to load ucode (%s) ",
-				  amdgpu_ucode_name(ucode->ucode_id));
-		DRM_WARN("psp gfx command (%s) failed and response status is (0x%X)\n",
-			 psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id),
+			DRM_WARN("failed to load ucode %s(0x%X) ",
+				  amdgpu_ucode_name(ucode->ucode_id), ucode->ucode_id);
+		DRM_WARN("psp gfx command %s(0x%X) failed and response status is (0x%X)\=
n",
+			 psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id), psp->cmd_buf_mem->cmd_id,
 			 psp->cmd_buf_mem->resp.status);
 		if (!timeout) {
 			ret =3D -EINVAL;
--=20
2.25.1

