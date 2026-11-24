Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD5B606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZOrPeOQa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B8110E0A4;
	Tue, 24 Nov 2026 02:58:48 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012067.outbound.protection.outlook.com
 [40.107.200.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA4F10E0A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 02:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3NxwHmTDElWE2j7R0VvTya4UvnkfZuiyCIars/1SwPwCarjxhzzm+nN5KSZSNWVw0Cwv0f9+5qQq6c9XCqfYJm+AwUc+Hu/xLs4XnNYidKl2NUtPOJ+qyq+qAm7j3GvLZZgNT0fXm2zAqZbXA03LKhOJ4cvxnOxKCtz+9sYjYYeU9g++7VtQLzaKOeyWuJtigKvrTI3OIXeqxfRAtI0VWxi/NJQGdGEKpaf4FkQS9m4AZlVT3Q90tnoUUU3KntKRkReGcH7BUFl/Wh6KW2a4t+qtiAjZZl6Q47W+j6p9zwYqDwlZKhQbg7Sog8UGrRsIUiBFZPYXAG12DV6mwgndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Y/R6hK+WKepb6sqHKfH4PhiqIQPNUhgA8cYKG1PCOo=;
 b=bIrV0nb47GLqhZjsZIhKfcAIBE60hIzNo5CL6h0Kfkwx41vy9emcmtZDqfItHXmZl8GsV6XCphA/Jy5qUr3lV7KwdcIxf2r0kXB71rfg+gG2IaULvcp/tLzr6mO3WY3XjfTKDXBzTbIsavR8u6gZIg3+f7kcJVPl/BMkH4seV5kRN6U7YiFKA7rK8HOSNNhX0neWeDyRU+gB23kX+WWLaH59vUXGMaJNSdNlYkiR7FhjQFHUlpSlR06rbPrfQI4hn4xeM5yUddqMzRd70W5yR50JeEbsUibM91XeXZK+UZ6vOSmvCtM813CkbsfFg1TkxjBKbGBsOiTa72D4+pcHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y/R6hK+WKepb6sqHKfH4PhiqIQPNUhgA8cYKG1PCOo=;
 b=ZOrPeOQaQnnI56ZQMdZS4v1TOAUv1onSzpBsO/gDV1qNeyMuxa8N7OX3SZMtGSntAI3C1SMh0ZORvGvwlMnv9TOchxWn72fsGFaoQ2oDwP9IRl83aD3M59Y18+NSpLLRAwQrFIBV26h/ueLMdkfQXpLspNYsPw2WgfrHDwV4+84=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 02:58:37 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 02:58:37 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: fix deadlock between profiler_lock and
 dqm->lock
Thread-Topic: [PATCH 2/2] drm/amdkfd: fix deadlock between profiler_lock and
 dqm->lock
Thread-Index: AQHdexuBtWx8orWt40eniL03yfo6B7c8iM+Q
Date: Tue, 24 Nov 2026 02:58:37 +0000
Message-ID: <CY5PR12MB63699754F14EFDBA8432BBFCC1442@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20261123072247.3612981-1-perry.yuan@amd.com>
 <20261123072247.3612981-2-perry.yuan@amd.com>
In-Reply-To: <20261123072247.3612981-2-perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-24T02:57:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB9066:EE_
x-ms-office365-filtering-correlation-id: b2dc65c8-42c3-4c69-1c91-08df49d6d5ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|11063799006|56012099006|10067099003|4143699003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: /sFJzrYPVPluYdyFCX4tFORc3QTKjo+MtOJlNVTQb4NDLKMCbTDQ70W/vdpktCWRRxEliWZfYSnxNBwpAZwBKmbx0f0mgJhJUB03d3MMItVBvEkZavGcJh307bRvwjYKonm2F9IXwgSsS27jr7aFL7nvl2Sg+jOsFzvH+C8X7JQHf6SvkmdPUQIZ2LWAwe2TvCFL7MHXJdZTphyoxRFBg64r9nZkE67zLjwElxT9ioGNBvt1cQe+0Q8vd5T0L1f0Ungs+w58tdjDgg3y7lLgmlgP6bxMLAi89TnUFEeRpF17qIwxJg5Ibw5GC6y2VIYip42JGSu8ryU/dOWv3xJK7LAFYjznSBPGfuKUqUrTebwPUg9JMV6yPQZUvH1CxV6eEt9LFAfshjslpZeFhfTeuoii1EqdDqQ7O5YH/mO9lnZTzxAg+gVzPY7d+gYc9MtK6CEWhMN3dn2OzvYeUaadjk2U2Bpm6nqCESy64Ny9dajio2zF9SnqOda+1mhBgJ1MplXE+5WpboDolFWBF6PxQW8FprnyETBSwMYlsHgPx7Yn33pbEvI5M9n8HyULnuK1BlPd2ZyxD1SGEtSDNLYxPKYNe0vSdHVXFmbwsO0vy7xdRowvg3GtjynczSV56yrXSRRQ7CQTRFJsvC7dsFqJguIbgLqAhpt3aH4FXcH5zS2MlwTjNJYlP81sKjVA8Mh6pwKdrR6UQ4J/G8dGlBB5bAXpOQKoKXoKZYeBoWB32SE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(4143699003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?paIQUFgoUo+CwORHAtsP++w3R1nLKQbdqDUNfIpL1KJlkvho/K+8NVqt2i/q?=
 =?us-ascii?Q?2XmrdE9ffFbrM/OzgpGxx9HKjV46BZz+IfI+phYTmI01T+oQddthsm+sFh0o?=
 =?us-ascii?Q?o5PlqKG4Ui3UR/NXIppidDsw6HV9p86yfHC8BNG0Wrfz+pzqQm1nMDepU1pP?=
 =?us-ascii?Q?BfTFL7StFsdGPT62lOoegYCZjUhwXJN9ZjxHX54s9wF+dTHFZxXBfJPl+H2x?=
 =?us-ascii?Q?LamVIAeZCUKtBmD3NqlAKNcTAusmLF1I2MDWt1NQkXvB7etQc2GGVxEVudbQ?=
 =?us-ascii?Q?GDbO9es89EL39bDxI81EfxzXnVUjjMPwktS4T/zEAsGf8GSTOwsKa+/bEXZ5?=
 =?us-ascii?Q?tBIHfRwTbSJKtH3+fIcISJallJI3kp6W+jqBYTPqgagN++4imabaXYhhhJs5?=
 =?us-ascii?Q?mZzm9Iq0w/iiKX3aagvv6MT0M+SLEP0h5OeOVPUv2hqZbPzX77D0i/UrB3us?=
 =?us-ascii?Q?qYA9BtOGFhoCYOuMRbuwrXv/Rsu1pRkyEJIBHG4Lipz4btjuU4GROqwjIaaJ?=
 =?us-ascii?Q?EhKhtvsOo0WDTcqXDchPzjMgKUlFYSp8Buofz7gYpzGDy0MP+6eIFB2zbiJl?=
 =?us-ascii?Q?8D3Hjh9kK6in+T3ASpzeCHPy/bT8E867nduIZH0PjO1l/JYwoJ91jhNPXQpy?=
 =?us-ascii?Q?eAn/bAaDpJQ28sVFG7MyW4kGCHlUFweBronqnKSe3XIJVk4d2Z+pyMJbw7eq?=
 =?us-ascii?Q?kDF+Xkk5MQXldS196iPq8vuddaoPgmXeBj+Uewb02MQ/ZuUIj1ay+KhMCOj/?=
 =?us-ascii?Q?5ZvzH8JPTMwT+PbjsJPRMUbJM8Jh5PVq2jdiucln9r//vDxmkh0OueSr/Rwb?=
 =?us-ascii?Q?nZ2f59JYeCuNFfOZ73iyNN9nURFgLD6ilTcbLxVGfQ4EbUfQjQwZyB8XLLSr?=
 =?us-ascii?Q?uzv2HYHtdnBi5DYhQXgvhafrFzmrBOiAsvPgYeXIu4mPJKK2eBDNgSyTnEa+?=
 =?us-ascii?Q?vZ1CjdKTysqwkWWtLB5dzyXpjJIVZhufK4NKd3/0kX41Cf7YApRRpi+Q4Ns6?=
 =?us-ascii?Q?SRnpsx4GeNlXky6vA9iUIajGnI0u+v/IiF/4VLHxlKqaspHJdLfYZH8D0MDw?=
 =?us-ascii?Q?LVwQmNeXwGRNXbeEqyaNHMX6E8Xf800Fb9dAFWYlQ/JpPs4KTjqq4uvr4qmp?=
 =?us-ascii?Q?C04Jou6bCHtz70SQt+YPw/MfU3lXcTobI6tCSG0y03DgMiJ5psgf8MceTXeA?=
 =?us-ascii?Q?BDQB2BrxpR8nDpM43h/bfFGTg0+oKHs1uQSJE47yUPvguVwfvFnc7/U+pf8e?=
 =?us-ascii?Q?QgCE8pgdbQq/zhA/JPGgK6p6A28EZg5EjhPPMGXa31tfGIR+NqcmbPkr2GyU?=
 =?us-ascii?Q?sFc34bPTIIeQt5yZex0BvPJmEJvziq4G+zyPJPeF6a209vl4xWcB8lEpQNal?=
 =?us-ascii?Q?lUN8e9z3U5k+7CXCFD4hjVK9LbifpoTl/KSAG/OTMwW1YbTiyC+TFGeIxtQT?=
 =?us-ascii?Q?taujjJw65u9gYH+UxXTdO6DehYyACmnZbH1DtZZgsCHxJ0WLceaqaTLkMXs2?=
 =?us-ascii?Q?o4utNWASrP2uEwMvsn8T0C7mjhqpwkzqK+eM6D8EdwNQS0cYjrewcq6nmKux?=
 =?us-ascii?Q?WbTZMU5gpjNEB01D0Gb2NYmfqgPXa5/lmVTHP85GQzDlQ6y2Ta/gk/5l5A5g?=
 =?us-ascii?Q?/bnY7eRiKbiKfZ1B/P7kZbYvA/EspphdSpPRAukS+yHhva94SpF9bVwB/bIB?=
 =?us-ascii?Q?rQGxar7YBE+vTzk/llj7ynJUN/ffKoa2UaTWsXHx2EUAqGuP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dc65c8-42c3-4c69-1c91-08df49d6d5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 02:58:37.0762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIurbWyjo2NUl8X19v3TElfJFMpEKwokxifruyFDBh55RPHiMIbqJztleD6IbVhd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

This patch is: Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Monday, November 23, 2026 3:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yuan, Perry <Pe=
rry.Yuan@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: fix deadlock between profiler_lock and dqm=
->lock

There is an AB-BA lock inversion between dqm->lock and kfd->profiler_lock w=
hen a profiler process exits without explicitly unlocking the device while =
another process concurrently creates a queue on the same GPU:

Keep kfd->profiler_lock as a leaf lock (consistent with kfd_profiler_pmc() =
and profile_lock_device()): clear kfd->profiler_process under profiler_lock=
, release profiler_lock, and then call set_perfcount(dqm, 0) outside the lo=
ck.

Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profile=
r kernel driver changes")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index b6981185c7ff..cb1ceae7606b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1230,12 +1230,17 @@ static void kfd_process_free_outstanding_kfd_bos(st=
ruct kfd_process *p)

 static void kfd_process_profiler_release(struct kfd_process *p, struct kfd=
_process_device *pdd)  {
+       bool release =3D false;
+
        mutex_lock(&pdd->dev->kfd->profiler_lock);
        if (pdd->dev->kfd->profiler_process =3D=3D p) {
-               pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
                pdd->dev->kfd->profiler_process =3D NULL;
+               release =3D true;
        }
        mutex_unlock(&pdd->dev->kfd->profiler_lock);
+
+       if (release)
+               pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
 }

 static void kfd_process_destroy_pdds(struct kfd_process *p)
--
2.34.1

