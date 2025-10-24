Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71472CCF9E0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 19:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B795E10E00D;
	Fri, 24 Oct 2025 19:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g3goTAEb";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D065710E00D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 19:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWppG5KE5w8cMFsC6b1z2lLINhz8JkghgNlvxIpa6aYC9B6NXCLz3awQk7oZ6UMRIhZ+vsTvOG/D28trIoBrMPavqL6fSeW/8Pljd6othKCMiuRufEJw0qCo8TT5YqyfLVTDr97Gs63FQ/knDFKlHnRBb/lOoVd7LpTffnAvDHY9kF0oQsyqtaxZCt+wvPpYONXWXfFLiB2MS//dSz+DLwQXp4GHbGugGY7S3QAWdwCGqsHWtL+1N6iN+56HTy1kCrsz8XOlKk8Z/xGcNC2tZufYUF72Vjy7otZrCo8/zs+IKmHg2lYD0kJB8etsu2Z52UpTwoJwwTYhdlRu3NpXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Rkdwp5IfuPUc7drVBnha6XGMmsHl05+KZAlmv8Arw8=;
 b=XVIjZBwiya1Kh75exBchTjFRrtcGhAHEDNEYHQ+T5CEVpyW7CfS1yOMe9IGtR2XPy754eHeXlmtzpqKzMjpl3G2MYCIrBqP1VWfmoZVh84I4pp7mtTP+kfAtKqfifPYBkIOLVD+8g28qc4rQ/0OyV7/h2TcvoJkXDdmoLxUribVQYxf2RN7LOC9lwdKdSDIjB+NN2ZuDvARDPSXuIjd1Dl0S3zwUkY5Q2/VySAA4VNLkBD5yPSdFeoKKKsuptKQmDO2gI/ZdFMku13qI82sOu5C6DNEqQNOLZh/nzjRblW3uUvV8E3Fcrq1DE1VzF0THwuYnd2XxkSzKeoZSzVLhrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Rkdwp5IfuPUc7drVBnha6XGMmsHl05+KZAlmv8Arw8=;
 b=g3goTAEbwL2hBptZhR51OD8x8WfCKpFJpW7pfCckSop8E9+nUFUqhy4nmrvS6e3HL5JoEN4Qi1xqwXhTE8Ag1j7KsQqNOSyHaNEjBfMhnKmwqf7ucXNvlwWd1h+3skrHLzrziQELt1qiGGSHfrU8Thhjg5fWuglbPAbe137RFJc=
Received: from PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 by DS7PR12MB9525.namprd12.prod.outlook.com (2603:10b6:8:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 19:59:02 +0000
Received: from PH8PR12MB7112.namprd12.prod.outlook.com
 ([fe80::527b:a523:24c6:a1d4]) by PH8PR12MB7112.namprd12.prod.outlook.com
 ([fe80::527b:a523:24c6:a1d4%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 19:59:02 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix Unchecked Return Value
Thread-Topic: [PATCH] drm/amdkfd: Fix Unchecked Return Value
Thread-Index: AQHcRRV3EmKQkE3KgEK/EkL0pFurnLTRtuMg
Date: Fri, 24 Oct 2025 19:59:02 +0000
Message-ID: <PH8PR12MB71124C72A9A51346D9FDF7458CF1A@PH8PR12MB7112.namprd12.prod.outlook.com>
References: <20251024183828.2954594-1-Sunday.Clement@amd.com>
In-Reply-To: <20251024183828.2954594-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-24T19:58:59.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7112:EE_|DS7PR12MB9525:EE_
x-ms-office365-filtering-correlation-id: 6f7ff291-a2ef-4af1-6c04-08de1337c781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wJJC0Lf+sdOrBM9HyCitPLkAd4m1bzYQlWgr3c9QgQOn38Z2As4OaL0X6rOI?=
 =?us-ascii?Q?VZCOePRZFU4tteIx3mFWf3DLj6js8eiA7HXMYT6ve5HsBbYuQjsr4SSvwAP3?=
 =?us-ascii?Q?/lJLkb/bsXqsU0dVkrMugxyTAH1Pr99wx2LsZVelY5IT81zuBwYz7QOQ72Fd?=
 =?us-ascii?Q?KjhWEPA2CDmVOFBGVu38acspLrxbnH3l6bo+PKokoIuUe3iKEkBVcccYiPOE?=
 =?us-ascii?Q?Iko0M5Cidzhv78B0GR2HXnrF05EV93kKubI6YTRKIdS8f2OVsanAL/bfZc5T?=
 =?us-ascii?Q?s1imKiPM8DtemgHJGtFCRA3jRjdEDDwId4j2Nd5ykMmfGB1z7mwja5oQJHWA?=
 =?us-ascii?Q?SarwxDN7gmAp9JgEe6SGfyBaGn+8OPknC8tiIVQIkL9nuJcbnecZdfka8K1l?=
 =?us-ascii?Q?zFjmjidvmms/aLmgTotLxVJ/7w/dD+jJWpfIjtSL8FZtAz+Hn+sJ/wI11cLP?=
 =?us-ascii?Q?isFvagzqTIJms/VZ/oIG6pwciGNjUrZCosYv4UX8BDcYcKUaumkob/7K0Aj5?=
 =?us-ascii?Q?zFtPg75Oe4MFDtZG1opR2+/IfTzSIHQR7IEaT/R+cZUKPpx1/p7vMX3rhZ4U?=
 =?us-ascii?Q?/a/fWQvE09nlF3qhp/1Jjt1Fy6ntqI4V/aGH9mMG+GwJOlFhDbUBlQ9MVSsG?=
 =?us-ascii?Q?qKVQpnzf8ntyEKhFsR0c6WuQQY4V6Ps30M2lATroO30n47DQgt0z6gwzSX0k?=
 =?us-ascii?Q?BljNIPWKTYJVwCPTgDdOBsKODJDLIenEj5TpFMjie/Aqa37c+eTfwxeI8iZe?=
 =?us-ascii?Q?1+X4jYr1ld8f2BiNZoMZ/KKCg7j9S2z40oy06yZ75Tioq/5TDvUyZAHH8dxB?=
 =?us-ascii?Q?4GDB0su0hc1ZtmIZOmXtK4fUx4YuYVwbccPytyxiBBu8GT/ZfELDplNZClJg?=
 =?us-ascii?Q?RY76zBYKrTRZll0tAAMrZYbgWNHYEWBInpRrCVyxR7J/BLLgY/aoCygRAUTM?=
 =?us-ascii?Q?vmayi/1DvhZllATCcSdmLSszSIlbtZ1b6xM12QdIZHb6WtcFdl3u8P0scUvq?=
 =?us-ascii?Q?dBv5UyeMQAiAdFIG0YPJ4V7V2x9pGKQBvgoDiAn/4eWGnZzyVJ4bdHYFfM+8?=
 =?us-ascii?Q?PXGAg5GO/thChwADr2N/FdBltdEIweWOl+1F5SPbOqNWRNGaWQuqZBVZ4SOb?=
 =?us-ascii?Q?uWFUxdrn4yNqOREm6my4zUDXhyscRHFDpXU1+q4jjDM+gP6l3KKhO0z2qHyi?=
 =?us-ascii?Q?U+nBQtJh2UJumLa7zRN7cSYf1AXYf98IDCbToyuM/UGWWRHaTQfGjvJFrbQs?=
 =?us-ascii?Q?OhvGP3TBkteyxUXeGoNRzjI85U6GbWDU2ic76jUnglBoubVxcS1KmgJVCKCJ?=
 =?us-ascii?Q?EzumkpNnii+8PYBAUyqxAqq+9FP5ckm+dx5hV0h8BCLg7ObjGx1i9/PrDbFw?=
 =?us-ascii?Q?CwlS25BKpLRHlCLDq6IDvDdMvpPNslQ3yD/CofPvVCGqrE7B7Bqm0YYGChzT?=
 =?us-ascii?Q?Yp/Wgo9DbAnv7ZHFKdQCRg0Q+ADjAev5kz4cl3Eea3LM0F1JaSBnbKgiKtI+?=
 =?us-ascii?Q?1jg/ICj/q7dT8P575Y+fEU1xLSSBEyBYWSMy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wYNew+tOG3DMxwRyH3w5Rzf9LdZLmFPeZ1Hjwk7kQL3uoejXZ9sG1vW08Ryi?=
 =?us-ascii?Q?4x2Vg7CU5fZIL4EIHyH+2knh+Cw6buxTCrNwRqWlFrzt3bwyRZbr1JRgka0P?=
 =?us-ascii?Q?lewlCSmH1bqdZE565c49Y+H65P19g05Qmxa1LE7nvs5EssOopKmMVcnThlHx?=
 =?us-ascii?Q?VnRKeUNaLvxabDaJkfJ18JWxD0cQaRs1otMbYsP1kD3og8JZNC6j6coWlJi+?=
 =?us-ascii?Q?jU6lovQWk/dJG1VUjYY/HP4mXum0NHR0zlOaxgJqhlU8S6Q1fgNT4Ei8iuon?=
 =?us-ascii?Q?/Ceej1mOUnKdwMB88KpZKCItReXUwduXbV2fZxuVf6dYpG3JVlN7wJMZL5PV?=
 =?us-ascii?Q?9QGGlG/FtBxu4kW6NNj8YzaqmHUMj/DYIh4kJ/KGAA3Lqr9CbZxODaW6xyPF?=
 =?us-ascii?Q?dafu/7GIcpcmddI9BvFK0yIdEbRtinJ0Z3ZRthrl/hiuK/DIzu2Wb0ds8xrn?=
 =?us-ascii?Q?+dG4N7hz4d3+QifQVLtMSKda7BThoiu2/j05IXGvl7BIAe/rHRugxAd99Kaw?=
 =?us-ascii?Q?04SteydhTenjTyFKUVh21ndG1zay5ZMqQnXomX9BiJib8C8goBIRiXgV/PfK?=
 =?us-ascii?Q?tuhYBQI3SPy65WUfAQ2IZMm7ypi/1gtVG1e8YWtnRkjX+gB+tGG4+qIS8/lt?=
 =?us-ascii?Q?jm+f9dPTAJfv2WTF32QJGbarIUlvmuLomZvo5Eoxo2jA9xdfnApjvsHKMpod?=
 =?us-ascii?Q?dH08TDUOHIg7fzNLFtkx9iglcp5JBahFiu2WJCcLYxBztnW0IfQtPZl42glT?=
 =?us-ascii?Q?rYZvFKbBCx7lGoSQwUi66UKCu7qaJ15h0YvDD+85dGOc9rKA9BUWHm+gddb1?=
 =?us-ascii?Q?Xllt7mSg71BK0Zr5Hv9a7TxvVZL8ezAlb9oTX9xhP4XUZNceXN3KzQ0Tcse8?=
 =?us-ascii?Q?UnqxB9yUXLzhD/kMT176fas/jD1aXcLFJy5jU0Sl9FV8/nixAlpE3ikmTkLU?=
 =?us-ascii?Q?Xlz08NKAZCVtjUA1wqj4uqX+Dr/i9Amy9xYEf9E73cM7O+HvMfJ72ccxyq8h?=
 =?us-ascii?Q?BAEQ3whRdnr0EVZ+abtWZU4ezeYuFPR6Mby715M38h68efmGqN2zBhcs8cWf?=
 =?us-ascii?Q?a9r7Kt9Cn2CXbXniwhetfduTd9f7+BXdunpQ+SGF7534E8Te+tZ7diikKtvS?=
 =?us-ascii?Q?dV1TcGWfF/J+xLxwVdpySlhU9Vft/XwM8iaK1yaiOFv8Zi8jj5dm9aKuYiQ4?=
 =?us-ascii?Q?66qrGNcAqEXeFOfrc96B/6ZGuWBbKVhzPmRYHdnH/kyDS4pQLq1t7fn/6j94?=
 =?us-ascii?Q?gOd80jL6w3/5LsRVL25P+MTelFGKQPdPtAmZkGGw6mjolBj/At5UJop8Ic5t?=
 =?us-ascii?Q?71qMONdcRlo2PN5yvaUJX1h9QQUJc3d1FQXmiJhS2acsxjdA6PgvQ3sfHrBq?=
 =?us-ascii?Q?AIR29cq39SsAxJ10DTLhbgHuU5nkN+UHygWL47EiqiyCoaN5o3zfUVEiNSH4?=
 =?us-ascii?Q?wbIV8XXnA43lVpqilu5j5jxsQv0vPJfJVj1j9exm6aUhDyI/HgwXbbovjpmi?=
 =?us-ascii?Q?lbAe1wqtR5PeIgojB2nrKbbpoqAKQlWWYiLzMVbw3NJcq12sXKQKQiy00Nm0?=
 =?us-ascii?Q?0Z3OTrvMpY/ztxO8OWk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7ff291-a2ef-4af1-6c04-08de1337c781
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 19:59:02.4332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19cjKisyldcI9CGPQsIz6fSNywj3FUzT7Ae62AlCmf0RMtxf+xVo/Kt+sXtBsX8qIublGAfXsmSWefLHZJt5cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9525
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

[Public]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: Clement, Sunday <Sunday.Clement@amd.com>
Sent: Friday, October 24, 2025 2:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kuehling, Fel=
ix <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Clement, S=
unday <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Fix Unchecked Return Value

Properly check the return values for function, as done elsewhere.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6e7bc983fc0b..3b696c58c530 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1897,6 +1897,8 @@ static int start_cpsch(struct device_queue_manager *d=
qm)

 static int stop_cpsch(struct device_queue_manager *dqm)
 {
+       int ret =3D 0;
+
        dqm_lock(dqm);
        if (!dqm->sched_running) {
                dqm_unlock(dqm);
@@ -1904,9 +1906,9 @@ static int stop_cpsch(struct device_queue_manager *dq=
m)
        }

        if (!dqm->dev->kfd->shared_resources.enable_mes)
-               unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,=
 0, USE_DEFAULT_GRACE_PERIOD, false);
+               ret =3D unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL=
_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
        else
-               remove_all_kfd_queues_mes(dqm);
+               ret =3D remove_all_kfd_queues_mes(dqm);

        dqm->sched_running =3D false;

@@ -1920,7 +1922,7 @@ static int stop_cpsch(struct device_queue_manager *dq=
m)
        dqm->detect_hang_info =3D NULL;
        dqm_unlock(dqm);

-       return 0;
+       return ret;
 }

 static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
--
2.43.0

