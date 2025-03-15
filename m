Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1CFC282EC
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Mar 2025 00:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E197410E0D5;
	Sat, 15 Mar 2025 00:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A2ovQiyZ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0668510E0D5
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 00:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3/zR/PwR/50e4JcDamPrGAAfJ5gGb7SiTrjFVj8gfdtCky3CKDyHVNwhuOJZDSxW00Up/4XkbQW9w/qhpno7jLSSVXCn4hT9Y6xWh069KabONCrOqt0OXqwvmk220eNxhgz8qNcl7A/vn/VeZq/oY8pLmwN/1TxvuWMuL3W/clfApfPTteLDpGcLkpJVTk6uR7jGesj+bV8y7OuO0cxzUQrwGPd0W7Qxt0g8j3xQb2ONX51Aw4iDs2uKe7c+FkUdj/fqMwbfUoQyNwQ1TQUXilsV18HpvGnfiIcwqtS7X8uJC5nliJDtt9c6eL5IE8+56WQVj6JI2V2zJbAdhSf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/6f93qFsCqVKPgF+AYkFfy7GNZE9cCzNg0LdjSLOkI=;
 b=KYF+UbzHouNjRaE2FSc4SpTL9drB9lKNHO+q7t/Wpa55yDfY3FSXUzgL6BgZv1LzB7zGp/tpKpVmoVPsp6SRbXuXYQS0LWrSuej1JsndbR9tC6agHmxTE99Nd6ku45Xj19sCKouVHu9m98nJfbmmuvRXxF5N0z4h5TJtE5WEBepNXd5aHxwQ1bQAJIoY7XNz1zQ7GVLD1NrnL0I+EARqeEyVhaJlA+F/cJpEpHR+0fIZoMepp8Vqh76yEGJe8x0qvkJIWW6KIkkRTiY9hcmnKSYUNnKgfQEYC6ifv9EbUnWmf3R14mjtp8Ml08a4zw6KP5KrWQ17aaQkc5jYiKZHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/6f93qFsCqVKPgF+AYkFfy7GNZE9cCzNg0LdjSLOkI=;
 b=A2ovQiyZ6rGiiZOMhcn331+xZvaznjIutsh7jXpVfqqA+Wzc3EgeYa9sThT6J9CXLP/5/iiiWqNZdPREsecwPOt0xgk4serR8f+EZB7yGhrLlo/BN7XMARsjQjmTmjt/8OsGkLVd+7vP2x+5MvaVknUobvDhxhV0t5+vezMZhJ0=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sat, 15 Mar
 2025 00:42:28 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 00:42:28 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Thread-Topic: [PATCH v2] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Thread-Index: AQHblR7T8kuCR4t2HEaslYyK5n+jBLNzGIIAgAAF8oCAAAkUAIAAM/Ow
Date: Sat, 15 Mar 2025 00:42:28 +0000
Message-ID: <CY8PR12MB709971F53D12F28CE7F4728F8CDD2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250314202211.251641-1-Harish.Kasiviswanathan@amd.com>
 <CY8PR12MB743573AF240E36758EED60DA85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CY8PR12MB7099D2903862C6C0943644BB8CD22@CY8PR12MB7099.namprd12.prod.outlook.com>
 <CY8PR12MB7435798AA23F01B8875E77AD85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435798AA23F01B8875E77AD85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=02da4d1b-0448-45fd-b918-53eee9f4fbaa;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-14T20:35:03Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|IA1PR12MB6555:EE_
x-ms-office365-filtering-correlation-id: 52b14d4d-3c65-41b2-6ed8-08dd635a436e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?61CuN4EYfQsnv5zwTwUXFVhbuabXl+I0oTwUNG7y1RJ4Xd6Sl8hUzk9TvnLD?=
 =?us-ascii?Q?3wqgzLeM0n/Cwjf2dQ+Ed1qF5+dhWZ5yKyj/UwVHR16LFAr/BmDjCQjD/0AT?=
 =?us-ascii?Q?oqnglYeeF6gkmK1xWmncokwIwrok/xxw/52aRJYih+BJpbQ46gcYYO7ozGcS?=
 =?us-ascii?Q?7qAa5P8dxC4nRKXAVhIBvcB7f1VC+Yxp3g8xKwAqFtE3HY7FjejRHwgIPtCI?=
 =?us-ascii?Q?BX6DMp+a4fLLAhIadrEA7XvJSZCwglQC/YT1gKST5+Aoxobk2MU+opJuHyEG?=
 =?us-ascii?Q?61sYpz6ONoU3WTfElNGbT9r0jSU2dUl+iPtrE7dNqvBpSQhwNaHQLyRWZhO+?=
 =?us-ascii?Q?WtHvdVvxPL4Hi65XN+wFXxD4u7uc+X0kbfeyQAORampp5k6tkWz3F+S7Gd00?=
 =?us-ascii?Q?+nyS628pzgxIUUc+jAu8Wb+44Kazgjw7RVB4EFhIAa2aO6CgsRjWbMid/yQc?=
 =?us-ascii?Q?URA0dbp2jvkFxCZvGRqP3dymn9xCOfN/yIMPKb0YkIdf47kHBhgQkdTR6NhM?=
 =?us-ascii?Q?Ov49Q0cHagLgabR0JLCAMQEIB6ZRHi9grD5c0LH+xD21yCTvjorwyTQ2Wc49?=
 =?us-ascii?Q?9l9YJMbQ/EA4yKPBB8zatHzO5a5n0moTp+xYPegh74fq5utCunaPHipeEz4o?=
 =?us-ascii?Q?5RmNqCU/1VfGSEuFOp7ll0RIoE5XRUB3yfBSMc7+YU8KCYGSxwCLiQhbol8c?=
 =?us-ascii?Q?jPbLucMlOlh0LJGvR3l4BfK7xytAmr/qEef9Prx/4bfUhk1RcfsTFsWKE5/2?=
 =?us-ascii?Q?WFzPoq3CmKqAhxskxv8gdJ+x/SjNvOMNNB5NJJZvwbffdAktkLuZLe/3oV3s?=
 =?us-ascii?Q?QL7/CHrcvnxr/JXCdec0eEvBIUCze0WXknLHoCAu1ADRetoz1eId6HNGu6cM?=
 =?us-ascii?Q?LRB6XQGRVHpdxLm0L1mgSvSXNnUaeBvoHYuwO1obXrvoHChiIFQ+oTgYAqky?=
 =?us-ascii?Q?oK7RgE/FS5OFGp6Spy9avJ+MUcsihft//0NVIKcnj5OAF22P8hM7cCuI1jo8?=
 =?us-ascii?Q?N5IoYtCt6B3zQxnZRoXsyzTzTb73NA7wsVVTO4VZSUp1MK/CAltkhWazrIw2?=
 =?us-ascii?Q?I6JFXzJ4sbfTHLBWUZw3zUzTvhF/W/jC+j8X/sHcPKSeGLXgEshv3E3TXd6V?=
 =?us-ascii?Q?6q+/Ohq4Fk4iosxuR45ODndF8KwM9z96RjS7GjnedtuwEViSR3DT5/cl3I6R?=
 =?us-ascii?Q?ZOwfxhrXs+0dv3s0t4ti6xCUELJ78ABZALqIR1Ps1fkyTLMQEECCAq4oGohL?=
 =?us-ascii?Q?aZA/rBqIJlHBAimZfJ7QVXRsXggM/TwYWk7CDo7CmZaj11WBAeRwd/Y2me07?=
 =?us-ascii?Q?krGetOyQN/vBjyoFWhZciWzRP5FlYZUZSnK4mJUZXCDTn/DxUUo/0iysvX79?=
 =?us-ascii?Q?o7VSAXIKHCpRRru6y+LiTapAPycjcrTOTIdh2hr/hoxPwcltBueyZQTig2Cv?=
 =?us-ascii?Q?c7eQCHWlsjAMQFNtXLG9WpQq2OwctVe1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8JUM5llKFJQb76SG5g696//vBQkFFkEpbqfWLS9Squi5DTUplUvAC0NP7bMt?=
 =?us-ascii?Q?9zVPkFe21qAv2oYOIL51kBUQedjQeT1w5vaDS0m2/GUaHcOakJOvEm7Q4x9f?=
 =?us-ascii?Q?97UO2ytM1BJol31IfCf+37pSATgFuQTrXtSoysuckzCNHzPcdd6H1NUMNLQR?=
 =?us-ascii?Q?kpV2BNEKAA5N3L/ozEPkAd7jAguh5PQ2Sk5hnQNe5/G8tRQZm5HR8yC4EenM?=
 =?us-ascii?Q?JDE2ZDz/zMr9ngESozcN3fc84Xi5O2/apuN8ItRmGTz74raD/gglM9Skst1V?=
 =?us-ascii?Q?2L7sbKbYsgtUusy8zccEtHGigrNWzP25JvXBp3RskrTTEfKstat/kryos5/E?=
 =?us-ascii?Q?lzwhAhNhtZN7oRl50EGVP4BO2y34C+5XonZ1EPaYkSBoKqlbGOl/ZiSzI+mR?=
 =?us-ascii?Q?7OP9U6KiTnnJSYx54II43aKMKc4VQVuWaI0KUyz/G/gh+eivNOehUMEIGZlt?=
 =?us-ascii?Q?V/9YBrjRN8pAS43M+LTwSDBDRuo9u+yJ8Ahjz/AQhGzQwJT3L7iThAzCQc9m?=
 =?us-ascii?Q?ijinmFh+dMtU5qWSugcMks9qrpxrRefhEk8Kp9UEqtsQjaGeyVGXyGqWvGHO?=
 =?us-ascii?Q?wcfsf6cbxEcXA5iFe9Bbm4bjCpkxR+8zpT0j1u/m67Q40S/7vlnG0g7vEaja?=
 =?us-ascii?Q?6l4wGURMgvizOnQ3uevV898MV0n3I/gOZL2UY/HX7yPJMMo/gClK7c/4Maj5?=
 =?us-ascii?Q?93HOiYM6+FI8ZTnS9pasFSQ9dMv7TKpPKWGKYOijb3v7HJHZfyolI1w+qQmt?=
 =?us-ascii?Q?Z7IJZFboTsddOdOQxMp+wAVUwnjKM2BQMN/FdULut5xaHUz4RZh/slAYgB/a?=
 =?us-ascii?Q?g3cW43EAhT1s2WtGFN0ocSoXCjE2sKbMyOB29EfBS+ZKeQyLj0LHgbJgYK2l?=
 =?us-ascii?Q?Y32mT9k0toX0jNYcS1CzbLielKaxTK4/WUwcqa+G+IWPv+ZMd8UBWdDBuBC3?=
 =?us-ascii?Q?pFdBJg4ph/hRUHSyX5b3gQ2Ma+dQXZL+6Zda1yDGgxWVRrnVvszFFmwPNR2M?=
 =?us-ascii?Q?OuJL+4rj2gBOrqZKOKRkUNHTBLjmX7HfuK/jhYeii6tQbibQlBPBTqJnCqe2?=
 =?us-ascii?Q?82CLvry5f+uxoV/rhX08banV4kP5lNNGZ6uLXCf++rO9+MKKIPKzXzdBW+zk?=
 =?us-ascii?Q?MIHlp6vBBKtFS1/EvYhxkIbXra+QUbPI2gPDW5spJHxX+QOQs/xJyK+smquT?=
 =?us-ascii?Q?rPbSIQvrzTjfVAqjSMR36IXFKq4uBogAkkDiQLyh+VtPEdKyN+HcRHxIMZK4?=
 =?us-ascii?Q?vcEMgpNKG2ic/TvLnqxN0VC1quTr+s4pIoqtrCSVwv/S9G3nKc27UVtVIK3H?=
 =?us-ascii?Q?THwGfps510SNiubvEKJY6QIA++/F7uG58x4B78KEKYbIdY+oGNMqo/wKQEEY?=
 =?us-ascii?Q?yMAVJfeVQvPXi7qe9sstP9q4TZu01jFHFq+0b11A5pAeMRuohqB6lJvJIoI3?=
 =?us-ascii?Q?VqKm9BvWcimsMCRvFurY7MAAAFs1A3l67HjFW9z3D3jJUYox3O0uuBHEUAz2?=
 =?us-ascii?Q?sxmDB3wbGWIuOwSEe89KcdicP8iU0kxr91nTzRxdd3ko+hkEfp/y2jHcThgY?=
 =?us-ascii?Q?0Z4pyw+Alcs4/R85dzk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b14d4d-3c65-41b2-6ed8-08dd635a436e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 00:42:28.5510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwNIX1y0FfvRyDy0IV3pP2LgrGAsnkXFNl99piXoG9xAcjq2bpycEOKm2hyrvv/EgHkWtZkIIG+lfjNHyFzrSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555
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

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Friday, March 14, 2025 5:35 PM
To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-gfx@lists=
.freedesktop.org
Subject: RE: [PATCH v2] drm/amdkfd: Update return value of config_dequeue_w=
ait_counts

[Public]

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Friday, March 14, 2025 5:04 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH v2] drm/amdkfd: Update return value of
> config_dequeue_wait_counts
>
> [Public]
>
> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, March 14, 2025 4:41 PM
> To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: RE: [PATCH v2] drm/amdkfd: Update return value of
> config_dequeue_wait_counts
>
> [Public]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hari=
sh
> > Kasiviswanathan
> > Sent: Friday, March 14, 2025 4:22 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> > Subject: [PATCH v2] drm/amdkfd: Update return value of
> > config_dequeue_wait_counts
> >
> > .config_dequeue_wait_counts returns a nop case. Modify return parameter
> > to reflect that since the caller also needs to ignore this condition.
> >
> > v2: Removed redudant code.
> >     Tidy up code based on review comments
> >
> > Fixes: <98a5af8103f> ("drm/amdkfd: Add pm_config_dequeue_wait_counts AP=
I")
> >
> > Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> > ---
> >  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 14 ++++----
> >  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 36 +++++++++++--------
> >  2 files changed, 29 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > index 3f574d82b5fc..502b89639a9f 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > @@ -436,19 +436,19 @@ int pm_config_dequeue_wait_counts(struct
> > packet_manager *pm,
> >
> >               retval =3D pm->pmf->config_dequeue_wait_counts(pm, buffer=
,
> >                                                            cmd, value);
> > -             if (!retval)
> > +             if (retval > 0) {
> >                       retval =3D kq_submit_packet(pm->priv_queue);
> > +
> > +                     /* If default value is modified, cache that in dq=
m->wait_times
> > */
> > +                     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> > +                             update_dqm_wait_times(pm->dqm);
> > +             }
> >               else
> >                       kq_rollback_packet(pm->priv_queue);
> >       }
> > -
> > -     /* If default value is modified, cache that value in dqm->wait_ti=
mes */
> > -     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> > -             update_dqm_wait_times(pm->dqm);
> > -
> >  out:
> >       mutex_unlock(&pm->lock);
> > -     return retval;
> > +     return retval < 0 ? retval : 0;
> >  }
> >
> >  int pm_send_unmap_queue(struct packet_manager *pm,
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > index d440df602393..3c6134d61b2b 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > @@ -310,6 +310,13 @@ static inline void
> > pm_build_dequeue_wait_counts_packet_info(struct packet_manage
> >               reg_data);
> >  }
> >
> > +/* pm_config_dequeue_wait_counts_v9: Builds WRITE_DATA packet with
> > + *    register/value for configuring dequeue wait counts
> > + *
> > + * @return: -ve for failure, 0 for nop and +ve for success and buffer =
is
> > + *  filled in with packet
> > + *
> > + **/
> >  static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
> >               uint32_t *buffer,
> >               enum kfd_config_dequeue_wait_counts_cmd cmd,
> > @@ -321,24 +328,25 @@ static int pm_config_dequeue_wait_counts_v9(struc=
t
> > packet_manager *pm,
> >
> >       switch (cmd) {
> >       case KFD_DEQUEUE_WAIT_INIT: {
> > -             uint32_t sch_wave =3D 0, que_sleep =3D 0;
> > -             /* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> > 0x40.
> > +             uint32_t sch_wave =3D 0, que_sleep =3D 1;
> > +
> > +             if (KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(9, 4, 1) ||
> > +                 KFD_GC_VERSION(pm->dqm->dev) > IP_VERSION(10, 0, 0))
> > +                     return 0;
>
> From my last comment, I suggested to put this at the beginning of the non=
-v9
> pm_config_dequeue_wait_counts call that calls this function.
> Then you don't have to make the return value more complicated than it cur=
rently is.
>
> [HK]: Ah ok. I didn't really want to put asic specific code in there but =
in this case
> code it is fine as you mentioned we have already overloading these functi=
ons.

Right.  Which is why I also suggested that you could create a front loaded =
flag or mask if you didn't like this idea.

e.g. of a mask:
declare dqm->wait_times_override_mask in the kfd_device_queue_manager struc=
t.

Do some defines in a header somewhere:
#define KFD_DEQUEUE_WAIT_SCH_WAVE_OVERRIDE_FLAG 0x1
#define KFD_DEQUEUE_WAIT_QUE_SLEEP_OVERRIDE_FLAG 0x2

Then in initialize_cpsh:
if (KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(9, 4, 1) &&
    KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) {
        dqm->wait_times_override_mask |=3D KFD_DEQUEUE_WAIT_QUE_SLEEP_OVERR=
IDE_FLAG
if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev->gmc.is_app_apu &&
    (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3)))
        dqm->wait_times_override_mask |=3D KFD_DEQUEUE_WAIT_SCH_WAVE_OVERRI=
DE_FLAG

Then at the beginning of pm_config_dequeue_wait_counts:
if (cmd =3D=3D KFD_DEQUEUE_WAIT_INIT && !dqm->wait_times_override_mask)
   return 0;

And pm_config_dequeue_wait_counts_v9 gets simplified to
case KFD_DEQUEUE_WAIT_INIT:
   uint32_t que_sleep =3D dqm->wait_times_override_mask & KFD_DEQUEUE_WAIT_=
QUE_SLEEP_OVERRIDE_FLAG ? 1 : 0;
   uint32_t sch_wave =3D dqm->wait_times_override_mask & KFD_DEQUEUE_WAIT_S=
CH_OVERRIDE_FLAG ? 1 : 0;

   if (!(que_sleep || sch_wave))
        return -EINVAL;  // for safety

   <etc .. etc..>


Otherwise, splitting the IP check is a quick and dirty fix.

[HK]: Going with this one for now. Can revisit again if more modifications =
are needed.

Jon

>
> Also KFD_GC_VERSION(pm->dqm->dev) > IP_VERSION(10, 0, 0) is incorrect and
> should be >=3D because want to also exclude anything with a major version=
 of 10.
> [HK]: good catch
>
> Jon
>
> > +
> > +             /* For all other gfx9 ASICs,
> > +              * Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> > 0x40.
> >                * On a 1GHz machine this is roughly 1 microsecond, which=
 is
> >                * about how long it takes to load data out of memory dur=
ing
> >                * queue connect
> >                * QUE_SLEEP: Wait Count for Dequeue Retry.
> > +              *
> > +              * Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU
> >                */
> > -             if (KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(9, 4, 1)=
 &&
> > -                 KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) =
{
> > -                     que_sleep =3D 1;
> > -
> > -                     /* Set CWSR grace period to 1x1000 cycle for GFX9=
.4.3 APU
> > */
> > -                     if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->ade=
v-
> > >gmc.is_app_apu &&
> > -                     (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9=
, 4,
> > 3)))
> > -                             sch_wave =3D 1;
> > -             } else {
> > -                     return 0;
> > -             }
> > +             if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> > >gmc.is_app_apu &&
> > +                 (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4,=
 3)))
> > +                     sch_wave =3D 1;
> > +
> >               pm_build_dequeue_wait_counts_packet_info(pm, sch_wave,
> > que_sleep,
> >                       &reg_offset, &reg_data);
> >
> > @@ -377,7 +385,7 @@ static int pm_config_dequeue_wait_counts_v9(struct
> > packet_manager *pm,
> >
> >       packet->data =3D reg_data;
> >
> > -     return 0;
> > +     return sizeof(struct pm4_mec_write_data_mmio);
> >  }
> >
> >  static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buf=
fer,
> > --
> > 2.34.1
>
>


