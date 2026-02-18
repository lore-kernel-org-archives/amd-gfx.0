Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C31E9A047
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 18:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B29C510E616;
	Wed, 18 Feb 2026 18:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MDmLQFXQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E63C10E616
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 18:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIH+9VPFif3XKhfD6ZvdM8+fL5naiBluh0j2JU8HA6DYpjKe8PK5eWLdx0XdolDajMNXyVzgF6k2HyJgnUlG7XEtOOO8O8mQmSBlNcTbNU0nsZT5p9XcnHDZSzPRN5yxUFgEyoy/MIA+p1BM+m3wO88163Yg6ozCkGRreBlidfxgnXGq8dpdA0So9bPEwHTLSwPPlLTlB0vjV+/dr1nLJcRbXRC7oDefyZlC+f4ry8SiYwsNTAQZnxB1z/vnlOLASWT4RPpzCuE7GF12OZobzdcKSec1z3qsbF0gRrL43Ag6hqBPtYGJXx/jJLDo1JiyIYsxcEudaDYQcWqeP+Gb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDJYRCnySVmPBcVJlkchobipi0x26IIaROoBEvNXDC0=;
 b=w4sVUDMV+bqToHnKak4tHZ6VS4zZ5xWK4MMN4h6oPBqOeoYA5mcYCnIuLBnznhpq23xvE3l+sESuNiKQALGzw8/G4Y8Th1dDvUPdtPpFEN/ZQ14EbynjhFi/Zz9Fh+Ls3XjhC9wy5llx1bRHMbddsCu9pSCQGKcVmuGbKE+SgMVwpTBirEVRzvPZhClqVISarRQJFZOK+EfJkBcfDcLupgLOQydDY0SQyqGtF9Vk3xclg6Ayzecro5l6s96/cttFtmjJJeP8o0xXGruR6h/qd+zD/+J3jJdkUAI7tPcOXvRr59TIhIs5aFQ8H4q42jwxHMl3shLlXDixwJMaE+Pcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDJYRCnySVmPBcVJlkchobipi0x26IIaROoBEvNXDC0=;
 b=MDmLQFXQG3BSdiC5ayE4YhNQlSpx8hE083+S4EQYJMFZjNSca3Cf0vj8kzL12HWptGo5EU7Iaq1Da543Ad9VhXGFo1LDaXqCxMw2tlwD7SA/Y6c9hGhLfjQBNzdV19pF+QEf4F+bzwRADQM0e5ZMWwZd4Cm6ETHyk8cFSAZqv3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 18:13:13 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::d843:c83f:a6b9:ae51]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::d843:c83f:a6b9:ae51%2]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 18:13:13 +0000
Content-Type: multipart/alternative;
 boundary="------------HfVO76qe8EIcTLIkAHR2GVye"
Message-ID: <8f4d596c-1888-47b9-a922-d48bb1adfb71@amd.com>
Date: Wed, 18 Feb 2026 13:13:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] user queue support for VCN 4.0.5
To: Saleemkhan <saleemkhan083@gmail.com>, amd-gfx@lists.freedesktop.org,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, leo.liu@amd.com
Cc: Boyuan.Zhang@amd.com
References: <20260210214729.80964-1-David.Wu3@amd.com>
 <4C922F99-7140-47A7-967E-D01DEF0D9ECD@gmail.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <4C922F99-7140-47A7-967E-D01DEF0D9ECD@gmail.com>
X-ClientProxiedBy: CH2PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:610:4c::24) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d4444b-61d2-4017-2889-08de6f196160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGpJNU5qOFNVcGY1eGtSeHl6U2RFNXd2NW1VbDB0R1VIaEJFM1ptZFJYUXR0?=
 =?utf-8?B?a0xzNm92cFROb3E5QU1RQVp4eGI5ZEJwZ3o2Nmx5bUR1RGE1K1JvRElIdWV2?=
 =?utf-8?B?K3V3VVQwSVJhNkVsK3Boc1p2akZpV1R4Z0NiVnlaSW92WU1Pa2VqQlJ4aXc4?=
 =?utf-8?B?Ui9kaUdVR3hwNVVBMFlLRytBNGFkRGZLRXdScXlZU0YvaE5vNk1pa1RxUjNF?=
 =?utf-8?B?WFRnK0NBU0xHN0FUSmNOQytjZm9ZM2Zwd1ZKRFBNUjJuTVB6dEV3TTVXVFZm?=
 =?utf-8?B?WXhhbkhrelVpMndEMlYvMVQxdXdSaFFmNWVtUnNNTEVBNFNraDk0UG55Mitq?=
 =?utf-8?B?b3VlRUJTRGNlYTVjU3JTSkNpaWRIVHJjc25ZZ0k1OWFPWGtIR0Z3WU1Eb1pW?=
 =?utf-8?B?d1VrN0xzSnZVSUU0dkZzaVl5dDlOZ2Qwemt1aWUraUpGRnAxZ1g2YzkvWm5H?=
 =?utf-8?B?Y1p1bTVuSFF2RDlQMjdLQ0NNVHF5UGFDcXBLbSthWWJ6M3ZyOGdtcFp6ZFB1?=
 =?utf-8?B?ZW8wYlJBWUZ2Vk1QcVU4SnNMU2FSR1Zjb1FSb2N2YlEycEZ6U3JrYVNYQWtl?=
 =?utf-8?B?NUd2K241T2pwMEN2cjR4VDh3RmFCUFlxY1dPaUhkTU9CenVQTmtQY3hkS0t5?=
 =?utf-8?B?VmNBNXlyWXJtaFB6TFpPVk9kcytvUEh2Q0htSU5BNWVLdDUzT0xabzdGa0xp?=
 =?utf-8?B?NHVQdDk0YkY0UUJDdGVHcVZnTklBQ1cxSlZzRlROb29SV2l1bklLUVBacDcy?=
 =?utf-8?B?cnZvMndVMVpLdWpDY2hoK0pRUzFFVENrU2YvUTZkMXF3T2p4YjZPYy9GRy9J?=
 =?utf-8?B?WE8vZmJLWlVuZ1RzdEdQZUtPdDBLMC9wRklaYTZsNDU4WmN5WkQyWmYvY3VV?=
 =?utf-8?B?V0hGWlVsV1lhendHU2ZVL1dUdFhnRkVyZjJ6c2x3VnFnM3hYaWs1RTVxVlpy?=
 =?utf-8?B?cW1KKzgvbVNiUGw0blEvcmFQRm1EZ2dGSnEwNFZKem9mN1RNZWx4eG5aeXdG?=
 =?utf-8?B?Tk5qUGxKcFIwUHpXT3hDaDkvb2pqV3Y1ZG13ZTFXcndXMDRGWWlaQ3d3OUc2?=
 =?utf-8?B?Q1lJa1k2NUwyNjNKRFhTam43UHdFM0drNDQyNG5EMGFXUjdJdnRseFZPTTZS?=
 =?utf-8?B?eUlKNWp1clFvTXZzWThvYStwTTg4cnZJV1FqSDF2SldrR2dSOFNFb25JelU3?=
 =?utf-8?B?QzdrUm8yZlQ2RnMzb3FtY2VTbnhWRGhkZDdsT0F0d2pRenJXbkU5VjZnbnJo?=
 =?utf-8?B?ODNqMEtSeHBjeFl1Qm9QRVJ2WkNtai9BZ2tZRWVUYnI0cnFTZENhQys1Q2Jm?=
 =?utf-8?B?WDdvc2hkSm5XenN0NDl3NDZRZjF4b1BNemdCUXV2SjZMdTJCUDdvRFhmd0hy?=
 =?utf-8?B?di8rNlExcVlHTkE0VWlVdC9wN09rWU0rQjhDK2RvZFFqZGJzZkVRUURJTHRz?=
 =?utf-8?B?UXlkbkx3RHBxYTZzNzZzeXBQeFJiVk0yUkF3NUpuNlB3WHFpWkJETTVPVTRv?=
 =?utf-8?B?NytVK2FqMmI3aXhBTXZwelduYW4vamhvVHN6bkxodGRienUrTjBVQXVoYXlF?=
 =?utf-8?B?Z1pwTUx5T1UzUjl5Y083eXluLzlJVHlPMFZrb1p1d2RQK2NLL2RwNld0TmU2?=
 =?utf-8?B?LzcxaUREYnFXcU4yYWkwa2YxS1JxSW1XQ2RyM1QzWnhvcmVHVTBtdnFISHB5?=
 =?utf-8?B?Qy9NdytBZ0lFUFNTdTRkR0dyRlNiRHNIMlJQTzRzeVp4bytxVU91U3FPQm42?=
 =?utf-8?B?TmQzWmlBS0xndEkxQnk2QXA2MEdtMENnQ0RvVVB5TTRCcTMwbkJlNUY4eG1P?=
 =?utf-8?B?T3RYYTNUeGkxNUlqMlFhWURZbmdrN3RHUHJMeXZWVnQvdERhU2tDSWIzZjNn?=
 =?utf-8?B?NGlwem1ZMmxBVTIrMjErdUhFREJyVDIvZjJOT3ZSZzJWcm9UOEZZV0JIckZu?=
 =?utf-8?B?SlRQYUNWRElUVXRYOXlxb0lRUHl2Q3pBQ1hMUXB2b1VqUWlCV1pjcTZoeHl6?=
 =?utf-8?B?Z3dBbll1S3V5a3AvT2thZm5rYzBWZlVWSVpRYkpTN2VtZkhLOEp4bDhoeTF3?=
 =?utf-8?B?Yk1GWlRRK04yUDFhdzkwU2QvN3VXWGdTN1RoNDVIOUlYWkQ5dllBOEJXbXZS?=
 =?utf-8?Q?t4oE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0dzeERpcXJodkpoN2d1bmUzMHJaOVF2cmxlTkhTQTRmeE0wcklCVjF5Tkow?=
 =?utf-8?B?QzlXTVd3RmpVVDJndklaQzI2dk1PalQzanNJdXdSRkZTbVd2N0NkK1k3Vktj?=
 =?utf-8?B?QjNrSVVrbTJUMTZSWmo2cktoVDRFT0RhYTNRcmM3aHp4YndrVVZ6NEdYRDJI?=
 =?utf-8?B?WnVnVXZWTFZEZXB5dzdaRlhaVWRoWjVFRnRGYWNkS1dnZkllbXZiS2JRODg2?=
 =?utf-8?B?U1M4cktzOFluY1JRR0dtaUwxMm9CVExGcjNTcEFDMGRJTXdCcVpqK3hGd2pJ?=
 =?utf-8?B?Mk5NUVYva2t4eWM5THNTVjZhQ2cyQTNIb1lFZzhFSVlFbW41VlpSVjB1dFY3?=
 =?utf-8?B?SDhGWkJvR25OeXFtZmpzVjZsVXc2NHJqTnB4VDN6eUtpOWJNWDZzclBOL3Jy?=
 =?utf-8?B?dEpENWdCVHVDNmltUllQVXlJR09xQ2FGOUwyOXFhMTA3VTNuWXUxZzA4M0xr?=
 =?utf-8?B?NnZGUHJOMkxNdnErcXFuWm1uVXlSSFZTUFdIZ21NSXZ5Z1hxV2RMK2xzbG0v?=
 =?utf-8?B?bFRjckJoUURuOWk1dkoxK0tUQXBNeGp5b0lXUUl5S09Ea1o4dkNGMmJjZmht?=
 =?utf-8?B?eGRPeEw5aVlMbHkvRmszclllYkg0bFZibXZ2OVUwZHBuNXhNOW11azVCNlZU?=
 =?utf-8?B?VEZDaUl1Qk1CYms5em5hMCttMktQRHc2aERpTGN0K2QrdE40R3hRT0VnMk9W?=
 =?utf-8?B?aGtjL2tUQU8rY09WMW9qaGo5SGxLRytMZ3FzOEJXUzQ5dGx1T0RuVGFBbjdD?=
 =?utf-8?B?VW03ZXo1eWFxSlJ5dE5IUjRaaldPbW52VDBxT2JoK0o1cW1hZnVlYWhDSHZK?=
 =?utf-8?B?N2RwbGtGODVUcU1MTjRKR2F0M2wvUUFzUGV5S2JkSFNGeTdIazdYOEx4c2cw?=
 =?utf-8?B?MUcrUytBOFFKSTdiVEQ5NGV0S3hqTVd4U0VHSEU1QVFsUnpFdi9aVmh1R1VM?=
 =?utf-8?B?NmgweHlDUUF0cTBCYnFxbnFxMDJUdkE5MElRaVlubDBLcTRSaUtGMTBCTjgr?=
 =?utf-8?B?NkVDZ01zZVB6bEF2UHdGODB4eFdCWHI0eGVqcU13TWdrdVJjck5Rb0pOUXlw?=
 =?utf-8?B?WlNITW44Y0oyNTNLVTBBeHJ5RS9oOFF3VDd5RCthWklSelBITWMxaDcvWXh0?=
 =?utf-8?B?NlFXODN4SENEa2hPbFkvcjhaazRHMUNtazljL0tORTM0dGFteDhkcnFLbVBM?=
 =?utf-8?B?cjdDVmFTSS9ITEYxV2FLT2xEQ1RQQVNiY2tRN1JFb29iVGgzbTM0MjhaNDY1?=
 =?utf-8?B?OXY2Y0ZNK0NhOWdzRE5LSGlrSndqUnVHMmY3M3kxL1Fwc0VmQlFWTkFFYTE5?=
 =?utf-8?B?UG15SHN1NmVHWHk0dHJJcytSVzBZUDEwWnM1bTNVS1I5YlRrU2FRd2EzNXUr?=
 =?utf-8?B?SnFyNHpYU21UUU1yeEtab0lwRVdza0tqRmVBRGdvWFBvZGlGaGs0ZjNFbXFp?=
 =?utf-8?B?QXVXa0lpOVNCRTlkK2RrSTJEcm51dys4b2FSUTFlTVl2azViYUFoSFJ4MEtX?=
 =?utf-8?B?d2pPek1yNVZyUjRKczE4K0RFNE5WOUZDVHFLRTNqTXVJSEZNZ055RjVNQmFM?=
 =?utf-8?B?RlFSaVNYZnNFaHNMaE04UDVSM3JEYWwyZy81OFdweWl5UzhlckhqZzlvMlI0?=
 =?utf-8?B?WlVMMTBieVB0RFJiQ2taRTFEZHUwRGV1b3F5RlhhQ0RUZ1pDQ2d4OWdkcXZy?=
 =?utf-8?B?NXR0YVB3R0RDU2RNcFhSd3g4R25HTDBsZFhOT3RZNG5WeUtmNCtRWGU3cU9a?=
 =?utf-8?B?RFNNMklWbWFlVHdxWUhsUU14UUFTYlBiZ1JZY2duN05SbFZZZG5pQld0Tytx?=
 =?utf-8?B?dnJwTXpIUVE4TlB1U0lRS2lpUEcwUSsyWlp5SjJFSWNHbHV0VDRGY2xOdmQz?=
 =?utf-8?B?bnA4Wk1ZRkN4TzJ3OE9LTWhoMW9sT3lPb0dVSlA2Sm8vMDVWUWNKWm92TnBM?=
 =?utf-8?B?cW80K3VMbjJhSEx0bGZkVlNLRjFWM0tzMktSelFHd1VWN3pVKyt0cXJYcTUz?=
 =?utf-8?B?VVhrK0QrKzh2bnE0Y1V6SngzZVZTRHU4MmhEU2xVNm5uRXlNSWo4S1Z3eWpU?=
 =?utf-8?B?VkhVWU42a1c4cXBodkdZd2xndWN2aVI0YUF1RnBYU1J2UGl5K1l1TGRadGUv?=
 =?utf-8?B?SHhrS2hIMHphclpsZXB4N0N4MmU5akx5eEJMSWFDZFBtOWcvZmd4WFJNNG81?=
 =?utf-8?B?aDM3ZzlDN2s3WjZ0RmhvTFVSZERTZnZERXc2bGlTYVgzblNPdWxLa29tdkdV?=
 =?utf-8?B?TXBXUHB2c2FTa2pnRWdLLzZLc2VwdTJ0TllKSE1obnZ6QkFsb2pRWGNmYUxs?=
 =?utf-8?B?Z2RlZ2QrQmFOUnk1OW0wU0JxRHlkbmFHZTdKazU2MEJFZC9LWllRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d4444b-61d2-4017-2889-08de6f196160
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 18:13:13.3856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opLvlK/MoyazwdqhIPIGsV78GlsV1lMwuawEmGuaCQ0O9DCoTTZKlBWXIojpXTK0iugjnTXjmNT00dSdwKzXug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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

--------------HfVO76qe8EIcTLIkAHR2GVye
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/18/2026 10:37 AM, Saleemkhan wrote:
> Hi David, Leo,
>
>
> Thank you for the UMSCH patches.
>
> Are the  UMSCH and  vcn firmware are upstreamed ?
> I want to try this on Strix.
>
not yet - we are working on it for kernel first. A few patches here need 
to be reviewed/acked, then cherry-picking one patch which is in another 
branch as dependency. I have firmwares used for testing and branches for 
mesa and libdrm to support the kernel features, but not ready for 
upstreaming.

David
>
> Regards,
>
> Saleem
>
>
>
> On 11 February 2026 3:17:15 am IST, "David (Ming Qiang) Wu" 
> <David.Wu3@amd.com> wrote:
>
>     add user queue support for VCN 4.0.5 David (Ming Qiang) Wu (10):
>     amdgpu: add global aggregated doorbell bo drm/amdgpu: add
>     AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL drm/amdgpu/userq: add
>     doorbell size for VCN and VPE drm/amdgpu: use amdgpu_user_queue
>     instead of amdgpu_umsch_mm amdgpu/umsch: Add VCN IP init to umsch
>     driver drm/amdgpu/userq: change mes_userq_create_wptr_mapping() to
>     be common drm/amdgpu/userq: rework on
>     amdgpu_userq_create_wptr_mapping drm/amdgpu/umsch: user queue
>     support for vcn drm/amdgpu: add AMDGPU_INFO_DOORBELL
>     drm/amdgpu/umsch: userq suspend and resume context Saleemkhan
>     Jamadar (4): amdgpu/umsch: Update UMSCH interface and mqd
>     structure drm/amdgpu/vcn: changes when kernel queue is disabled
>     drm/amdgpu/vcn: handle interrupt received from fw drm/amdgpu/vcn:
>     handle the suspend context interrupt
>     drivers/gpu/drm/amd/amdgpu/amdgpu.h | 4 +-
>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
>     drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>     .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c | 16 +
>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 -
>     drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +
>     drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 18 ++
>     drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 300
>     +++++++++++++++++- drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h |
>     43 ++- drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 69 +++-
>     drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 +
>     drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 4 +
>     drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 90 +-----
>     drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 75 ++++-
>     drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 122 +++++--
>     .../amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h | 10 +
>     .../drm/amd/include/umsch_mm_4_0_api_def.h | 12 +-
>     include/uapi/drm/amdgpu_drm.h | 14 + 18 files changed, 646
>     insertions(+), 151 deletions(-)
>
> --
> Saleem

--------------HfVO76qe8EIcTLIkAHR2GVye
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2/18/2026 10:37 AM, Saleemkhan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4C922F99-7140-47A7-967E-D01DEF0D9ECD@gmail.com">
      
      <div dir="auto">Hi David, Leo,<br>
        <br>
        <br>
        Thank you for the UMSCH patches.<br>
        <br>
        Are the&nbsp; UMSCH and&nbsp; vcn firmware are upstreamed ?<br>
        I want to try this on Strix.<br>
        <br>
      </div>
    </blockquote>
    not yet - we are working on it for kernel first. A few patches here
    need to be reviewed/acked, then cherry-picking one patch which is in
    another branch as dependency. I have firmwares used for testing and
    branches for mesa and libdrm to support the kernel features, but not
    ready for upstreaming.<br>
    <br>
    David&nbsp;
    <blockquote type="cite" cite="mid:4C922F99-7140-47A7-967E-D01DEF0D9ECD@gmail.com">
      <div dir="auto"><br>
        Regards,<br>
        <br>
        Saleem<br>
        <br>
      </div>
      <br>
      <br>
      <div class="gmail_quote">
        <div dir="auto">On 11 February 2026 3:17:15 am IST, &quot;David (Ming
          Qiang) Wu&quot; <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a> wrote:</div>
        <blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
          <pre class="k9mail"><div dir="auto">add user queue support for VCN 4.0.5

David (Ming Qiang) Wu (10):
  amdgpu: add global aggregated doorbell bo
  drm/amdgpu: add AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL
  drm/amdgpu/userq: add doorbell size for VCN and VPE
  drm/amdgpu: use amdgpu_user_queue instead of amdgpu_umsch_mm
  amdgpu/umsch: Add VCN IP init to umsch driver
  drm/amdgpu/userq: change mes_userq_create_wptr_mapping() to be common
  drm/amdgpu/userq: rework on amdgpu_userq_create_wptr_mapping
  drm/amdgpu/umsch: user queue support for vcn
  drm/amdgpu: add AMDGPU_INFO_DOORBELL
  drm/amdgpu/umsch: userq suspend and resume context

Saleemkhan Jamadar (4):
  amdgpu/umsch: Update UMSCH interface and mqd structure
  drm/amdgpu/vcn: changes when kernel queue is disabled
  drm/amdgpu/vcn: handle interrupt received from fw
  drm/amdgpu/vcn: handle the suspend context interrupt

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  16 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  18 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  | 300 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h  |  43 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  69 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  90 +-----
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c    |  75 ++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 122 +++++--
 .../amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h |  10 +
 .../drm/amd/include/umsch_mm_4_0_api_def.h    |  12 +-
 include/uapi/drm/amdgpu_drm.h                 |  14 +
 18 files changed, 646 insertions(+), 151 deletions(-)

</div></pre>
        </blockquote>
      </div>
      <div dir="auto">--<br>
        Saleem</div>
    </blockquote>
    <br>
  </body>
</html>

--------------HfVO76qe8EIcTLIkAHR2GVye--
