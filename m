Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAD9C44515
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 16:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB25410E4C2;
	Fri, 17 Jul 2026 16:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VSrat3vo";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D3910E4C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 16:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9FRMqlgYZJaKw2sBV0UYFyGGVUKabomnEEGMXhMGQIxO3QlCk9O7L4o7BViNSoa9Hx2swEqldPgTxdBzE43Yq6BrCNeNjTNECJnBZr8uc+IMgNN+menQ0lsb0Cx7tPDGVHBu/sVR3iqToOPLql48VTwamofEaAmtF3hIExW0NLlFkBr0BFHCmw2HhumRebMaHzDRlBWsbtdI/wYQ963LtEvcj5IkNxTs2MoIDWs3XwHq8ZJaMEQI7xIQ3RCpnITZBphu77y3IkRlgrnxoCq8NeVDvx4JzDZgqkvAm5e5VW2noNCvH+8T7COp0rFGBgXYpnECysBfoov/N1s90afbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtHsSyC4uJJU4B/Y3lE3x9qb+leTIPn1Dr7P7eCKNt0=;
 b=IqisNBJt6eJcAaXjK5e1dWqL0M2XUKU4ZkWw8zvA6xZGys9Xsz8upFEILj7A0HoW7UqmyfwIHMA55SG3n6h8VwxV876wTDGBOkDD0BvIxsE4agRsCIhrp12BUpHsH+DNSO2Ylh1LNPSxg35047+UujwbPlsAH5Iv9nnJRCCDclLO5kHmOJAlgz5DhG2pOIWY3e0wr8muolDOBfjhpx0HrbpPk64UBbeGc0AJ6IlPzWMpMHA7d7ONMBES5QvmxqUktqkn1uzu7ATTsJOv67FWJ2cogkqhPnJf0pjC+Xc+sizLd0lkxc1yCgyp41ycGQ+J28ViH4LqaNCiEXwezErExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtHsSyC4uJJU4B/Y3lE3x9qb+leTIPn1Dr7P7eCKNt0=;
 b=VSrat3voro73xtWgZ3TOybkKOCO7xCvkUalKtmrxnd7iKvbD7UgABW0I8zotRwp/XmwQZwN2ZmoW2guwOrpOtAc10uYfiLT4jznuGhs9w7R23p73HmEVn6740iyDk506s1o3cfsCum2XxTRvLN26xSd9LYDylnaXm/q9shMxadU=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 16:29:13 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 16:29:13 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: fix QID bit leak in pqm_create_queue()
Thread-Topic: [PATCH v2] drm/amdkfd: fix QID bit leak in pqm_create_queue()
Thread-Index: AQHc/pvT5ClGBwC5gkq0xEhfw51mGLZyFRBA
Date: Fri, 17 Jul 2026 16:29:12 +0000
Message-ID: <BL1PR12MB589821DBA41880C98D44744185C62@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <SA1PR12MB8600B7A9323EB2698E2C20A49FE42@SA1PR12MB8600.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8600B7A9323EB2698E2C20A49FE42@SA1PR12MB8600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-17T21:02:26.1860000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SA1PR12MB7272:EE_
x-ms-office365-filtering-correlation-id: 09e7660a-e35c-4a8a-d917-08dee420896b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Qopk0zc08076LlNFHPDwf8MD+1OjH/Im/PhCvug/8DVx4MXJLBw1iKIBjOKWogg+cwvdFLX+l7fkH21tpaNXUnuLjz6cqMDjX/I4WWORJU36eUwyEncQ1qgc4jGAZ2UrDInz0O7+TEw7zzA/mIIt2DcDgUlE+pnhZe/xMyBdCZ8/Fl3qT+AtKFkKnXINI1nc6qpxum61oQK3g/yIL31FxUz58lHjOG0n9ZoKi3jiaM+azBMbsnjREQ6d1xtLru1VbI8pBmyZuYkPt6Ba416U34hpt87RFesqzQqWGgQIDOe7CNmRnu/37hTWLS5ycvtx/FI+GX6W+FIDDOVj06OBMlOM7mh1uRupYd9Oka9F3yyJFMUPxMYuSwu4X5VAwi7bElxulsXDrezqX2tYg2FnkjHLzrUtoYu4f35bPx225w0Bhoih9cYFHzWGYxnkXCHvKv3jc4hy0nQVWk94GqRmjQP8aDCa0bKs44I2IeoTykZyVZ4xji/5kJ/q7wCSxwaVXVGR//O9TnQW9iNC8OPCPe0iEpP0eU0Bztozy2KQgZFHeGK1oBesa5ugZ9GG3r9FYXKzdCVbL8c+uW6fM9UC8vUS+ESoFhr7i35R9at95sIVXhfCukp2bh07mUB5e8m+EhzWzRllXMpLB3esSJ5zOrp/oy0Om6SVTXUp2Yp21kfw0HohXLi3Fibvw8NQawMvWk5AgQw7jZeDhX3PkWfN/xNYCW9pmkyNF3HMvqki91s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZO/4LcFmfncw9tBEZiK1UK5BEgDWiRjcWCCZ/OlE4H5pVwoTf0u2PY6SbhC5?=
 =?us-ascii?Q?NGly9MWB8gvmYatkLkxiIITCGwYS644dGTxlBJqV6hZBjlYYWaURL3F+Lj/3?=
 =?us-ascii?Q?qb5m/xOjyTu6/uLdU4/qdL5e/dOdga3SAzPgbu3uGtQ+wbj5NzE951QmBGoH?=
 =?us-ascii?Q?NxjlYSzFhj7Xwc3/gKMVBCzCuRBjl9kKt+s6iG3gfttOTSZSBDOmhLI6FYKY?=
 =?us-ascii?Q?z40nYX9DbhSERjTk6d4dSU2FdPSHwQcn3rseVLPmnx7QTptTkHJYxihzWBvY?=
 =?us-ascii?Q?dPD0uAeRl2zBlXyTVavHcPtnEKf03kAHNwcV7svfl/lx4RYzBWDITr0kIR11?=
 =?us-ascii?Q?e1wzsvu5yMXX50vlv2UP5i9I1PJwwzsLnMeiVCduuSWzTTFZDL05jBTyqq6G?=
 =?us-ascii?Q?IkNpdrJ7xtcX0jzvIoZZ4AJN1bEzCcYukLKZsl+Xc81qzYmQv6USBmTy6zW7?=
 =?us-ascii?Q?CfvEEaXiTJtxKOeI+FcAy5/pA6aCy0Pua2rgCWvIHGPweuwPuDmXYOeKevoT?=
 =?us-ascii?Q?2kTWdexzC2uUOSVIERKRL2TixsYAl2CaudDQtsOyGDZhOiX3cHSL/Ey4p3hL?=
 =?us-ascii?Q?VcHLv57pFg5XV8QgLVoF6n68iOYf6F67VCOMXAjzgHfuBWN3YrKd9pltqBG5?=
 =?us-ascii?Q?QxWsJ9OweKUC/oR36beZZCXxDCKnJRi1POq6o6HitdV+SDY+88J9nwNBsFP+?=
 =?us-ascii?Q?SvfNAuUVUeLJ+F7lZ6dY1rKnYYU65lQGhGEj+WcZYRZMbDptP4DZvyYWidQJ?=
 =?us-ascii?Q?c3se3vI2nJaATJmsXkKkmjn+rejBYemAH64jNWt4t7V+YETC5Czycmm8YwN1?=
 =?us-ascii?Q?yX4gRuk8pgyjoYXRYcA71B3+2RVrCzF7+FrXtirkfKT2GOfWFCN9mbZRhgTe?=
 =?us-ascii?Q?7dk9kZy+04ougBYOEHVoQJVmWL99Xc9Q0tKsnv3WghCyP/1e7RJBSi92O8zs?=
 =?us-ascii?Q?iQMUMXjIzAPE5q7qz7fTu05GbfUADUMsX1UU0l+J0bAh8rD5IhXytLxDo6Kt?=
 =?us-ascii?Q?j+BYUtPS44PXUlXLOoF983nLW0OVeu/QMSshMuM+3k+foN8y4zHqPC/QoQRK?=
 =?us-ascii?Q?iB3JJe1Q8Y3WKp88c+1LoDoGE2h70kOcKsWNsK0a29XC+KVzF8NQ2x8mTYCW?=
 =?us-ascii?Q?q7wpae+ZOqoDCRwznttkssKXsn0wCPyewIqmpb/xkBBXLR3S7EF2wHZOvKov?=
 =?us-ascii?Q?/F+kJVokRtOEYdCX7QwP/LM+TXybScgQGcEvlF5U0Bdxq5PdkAj9iobGBY9U?=
 =?us-ascii?Q?ZgN9scoifrvD11ylKdx2TLBpnuW/mGmOf54NDUwuUtZCHJwKQybhzciOK/pl?=
 =?us-ascii?Q?hvUeHiHiMailL3/6iRBbVgl9nlbZuysSH1WQPyqe29fMS1izVMDYf9Q2imaQ?=
 =?us-ascii?Q?TIffLUUEaezJX8civJfC2rSzZYzqXe87LFZ/5AWD5X11Vf8NK8ghC92le5Nb?=
 =?us-ascii?Q?OMRAyPi/fucnw3vToggVLClmnWq0SmC4LaISBlWV5eH5ezJezlIAXcVfX3ws?=
 =?us-ascii?Q?fqTyceGwygXvDtHWqRdZ9KOY6iE3DPEMxwPeDo0bQ6von5NvGP74+ID2RkTQ?=
 =?us-ascii?Q?lZN5gJlaOi1tKeMpRDmEhGUfXi6tW8/ujbG3OIa/3/q15YmauweCtT+WG58D?=
 =?us-ascii?Q?jHAw2LjtX4ddrB4UoOPibOW3RBQ9DM3ECTAqVMAoNUAJ9Hkl9vW5vid6fPLw?=
 =?us-ascii?Q?UvI7WiFkOyEmuZewxg3r6ce0n9YWc3Gjf6XIbXVgY8qVx7os?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e7660a-e35c-4a8a-d917-08dee420896b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 16:29:12.8133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJaywrcoBsXUVvJ+8XhdB2eqor0a+cSqT7TCJjopEOr6ID652K0y9eJfhhSBABgw3CPOmFi91O9Dw6lFtyqH0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
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

AMD General

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Marioukhine, Vladimir
> Sent: June 17, 2026 5:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH v2] drm/amdkfd: fix QID bit leak in pqm_create_queue()
>
> [Some people who received this message don't often get email from
> vladimir.marioukhine@amd.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>
> When MES is enabled and amdgpu_amdkfd_alloc_kernel_mem() fails during
> the first queue creation for a process, pqm_create_queue() returns
> early via 'return retval' without going through the err_create_queue
> cleanup label.
>
> This means clear_bit(*qid, pqm->queue_slot_bitmap) is never called,
> leaving the reserved QID bit permanently set in queue_slot_bitmap.
> Over time this leaks QID slots, potentially exhausting all available
> queue slots.
>
> Fix this by replacing 'return retval' with 'goto err_create_queue'
> so that clear_bit() is always called on the error path.
>
> Fixes: AILIKFD-813
> Reported-by: Deucher, Alexander <alexander.deucher@amd.com>
> Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>
>
> Changes in v2:
> - Fixed author name format to First Last order (suggested by A. Deucher)
> - Removed incorrect attachments from mailing list submission
>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 1234567..abcdefg 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -378,7 +378,7 @@
>                                                      false);
>                 if (retval) {
>                         dev_err(dev->adev->dev, "failed to allocate proce=
ss context bo\n");
> -                       return retval;
> +                       goto err_create_queue;
>                 }
>                 memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE=
);
>         }
> --
> 2.34.1
