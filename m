Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C702AC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 20:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BCB10E8E8;
	Wed, 10 Jul 2024 20:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zZmxmuP+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D1410E8E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 20:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcrJpWn5wBqqY1jt8qNlgQ/h4jsC0Knn1MiZFX/JOO022l8Xhq6PiwbMf0HwEF2B50Ubmop9let3xhtXyAipmG6g5VL48UBn7rvE6fnjzECOutSdFLT+Ondvx/eW2JKV79iuYkoHyzXqplwuvwlVjm+uT5IC7icq2ufHQkoEB9x4BbNtMoxe2ClFoq9eCWWiSz4kdyq/mneTm8cR/wzB2add5yYrcQ532drYhBhAqbiRUTwuT/MXD2l4mqG2xU+qhiuQ6Ywe1J025s8O67VoMqcV6jv1MaIayYE5tE6hoM4q5dQTJR8CfUof8x1ma9W5H94vXku753CZITZkI1Mtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9RllsU2Hj9ALeZP4dsuXMJrLOa6VArS35GaPwA/06E=;
 b=ZNcdmfvtrLMGpsqXLvTFzf5zDhmH0CBwyq52TD5hoxophDd/T1WA9DUWkACssO61nX7NvFukLI07eMt3MS5ZAU6Nen22YP42oZzrdzZh3S7e5ifk2Du/GSnqWVUGP1LwevGPNpHZAXU2qYM4RTZ7yvJaX1qkjWfKOpFfZvJzdxHrIE1Z0l+v8awEwZvHSYWBuP6sif8YbOrSkyPz+azHbgbyyUcEzmcEzrtGi4EIHF4ITT0dCiqr4i/yaty1tJeB2RTNAuPHRNJqMWo73cW2dDSY6GGnZkOw0kkCAcVJQRP7OfRvxvdz9kC6Oa/VN9XUl1toXtUrO6Tlse1TzPxsgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9RllsU2Hj9ALeZP4dsuXMJrLOa6VArS35GaPwA/06E=;
 b=zZmxmuP+aWd73d/dpPWrrwt7Lw2ZBHS1g1HW+2/4mO7ijwbfv5iXxwCXL+0F4KoRAitnb4vFE5XUxlQG2L4fx+kEdbSM3ZYeB2HZURhJVJU1bD/nXFT0WTRckDTBDpt9scVSD8avUrXED2HnO3EJ/pMz/q8Zbu73F8NOI/6YqoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 20:18:03 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 20:18:03 +0000
Message-ID: <0c6c6128-15e1-4b17-8309-26d2ed0c73e6@amd.com>
Date: Wed, 10 Jul 2024 16:17:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Allow display DCC for DCN401
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240708160610.1354015-1-aurabindo.pillai@amd.com>
 <CAAxE2A4gOcABsskv2e3Dwc_XVaXs-CmfK_D34nZgFjY3H_qY2w@mail.gmail.com>
 <90570011-55f1-4607-a4ea-dfd167f66315@amd.com>
 <CAAxE2A6LTSzfyP1uKrPYOotC9+_uNU+tZPfu4EZpB+K9_XL1UQ@mail.gmail.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <CAAxE2A6LTSzfyP1uKrPYOotC9+_uNU+tZPfu4EZpB+K9_XL1UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::31) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SN7PR12MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 963af0cd-1c1d-486f-6c90-08dca11d6718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajVvOXk5VkljN1U5V1daK0RObExjVzNleHV3eXVBK012R3MwS1ZCaFJNWTNk?=
 =?utf-8?B?aCtwM3FHNGIyeFJyS3hEbkZUVDhLOVlaODFUN01KWEt1aHp4Nk0xRGYrdk9U?=
 =?utf-8?B?VVZNTlNZSWRwMEFRU1JIdEhuK2t5czA2c2N4YzEzbVhiTkV4NzMzajVGbzEx?=
 =?utf-8?B?aU5Uc21yRzRjN3VMOTlwbS9Tc1RKeFlBbXpsWm1GS0E3ejkwM2pKajU4bHpG?=
 =?utf-8?B?Y0ZpNWg0Zkg3bHNhMWExL0V2dlUwMStQQzdGU0dVUndCMkM0K0tqMEo4MXJh?=
 =?utf-8?B?aFRta3RhQzUvOVE0aUtkd2wyYnZZM0dUODdYWTRkbEFhM2c2OUNzTHpORU9K?=
 =?utf-8?B?dWpTVUxaUWYyR3NjcFh4QWVEOHJaemM4S2hxNCtZdUFzWW1XTTdybUFWckFx?=
 =?utf-8?B?M0JPZEg4U01WM0R3WHVXNFc4MW5YV1ZxRE5NRGh1OHYxTmJJaklxTUJJOTZy?=
 =?utf-8?B?ZGdVVldQVGN3dnNWR3NYb1haOUVRbXNUcHp1MXc2NkVZLzBad3F5andFRmo3?=
 =?utf-8?B?U25GVU0vRzdQMDROZ2N5ZWZBdjBLbHYwV1JGejM1eVFCOU53a2M0S2pJNWZi?=
 =?utf-8?B?S25leFM3eFFJVXVHbTA2cGtGckRIQ0I5aHlrOGlINzlSMTZsaG1BZUgrZnBP?=
 =?utf-8?B?ME13ZlpjZ0pNRTVwRjNMWm9SYThkeHRuMFVTY2ZBUnZGekhXZzN3dG13Tkpq?=
 =?utf-8?B?bC9TWGpKQlBYS3BSOHZRZXdRazllK0QzdTRkc2lRRVZlMUM1K21rbGFrSG9h?=
 =?utf-8?B?SllMSEFyeXFOVzdFZ2xCTjJLeVdKdHVFeER3OG4zNDlzYnZ5MVBkR1kxelZP?=
 =?utf-8?B?a2c4Ukd5ZFR5aTRQVlY1YUNBblBvSjg3NytsbExwcGVYa280eUNEYVhVTnRC?=
 =?utf-8?B?QXVORktZYjhvaFIrQm9WeGs5MStpVXgyTURxNFoyd0l4b1JzQzRiamJrcEVa?=
 =?utf-8?B?cjQ5cXVFZFQ5OUNwd1VDNlBHUUJEWlBXOE42VkdacG4xY3Q2d3kvTTZncHFQ?=
 =?utf-8?B?UlBuWUJ6MjVqd01NQU9XYTlvOEZMQUJBZ05NTUIwczUrNnZFVFF3bysxZkhV?=
 =?utf-8?B?N0FUNnRtL0ZKbjhhcDFTSVhxMGRMOHFuSmNYZ2JWM2NybG9qSGl1WG01QVNP?=
 =?utf-8?B?UkJwYnovOVFRZW1MTmhtUVBjbzRaSzFnTG5OV2h1N29aREI5VkxIMzJmbmdN?=
 =?utf-8?B?cGtKNHpkVHVTV0grZWNvNFdacXEzcGR5NWtTUHZZcHBTZ0piN2cyU3oxYkNQ?=
 =?utf-8?B?MEJsdWFKMytyTXVUcmM4U0lLa0h6RlZZWjA0Y2o0RTVEck9pWk1HUWtUT0Nn?=
 =?utf-8?B?QUdBbCtlUzZ0eFU2SjZjekF6NlZEcGM5bmtTcDNIdEozZDlBdERoUHA0K3Nn?=
 =?utf-8?B?WWNhbHdZWXU5U1piV0MxeFhmR1F4cXpUWW56RjIxcklzVDNvZjZuRmQ0elpy?=
 =?utf-8?B?K2RaN0ZzSU9CcDJGZ3JPdTRZZnNOTWxvK1VZVmx2cUovdzlYME43Ry9JakJv?=
 =?utf-8?B?M1VDdjhrSnNkZzBHOGRMcCtFSGtJeUVyTEVkWm5RekxJV0VIUzVRODh4dGI3?=
 =?utf-8?B?cndSWXRiblJvWUtSOVNIUGhTZmJlc0ZEeDlabmFROHd4SG1BNVA0TzRyYVpO?=
 =?utf-8?B?WTZTUHpwbzBHRTM3MHJDdkxOeVpQZi96N3JBcnVrTTZkdEduRC9iTUtERnpR?=
 =?utf-8?B?aGJrS0hSeWNUWWJ4dHZPSEdGOU9tNFVCS2czU0N0SElHcENCTTh5d0s2bFF2?=
 =?utf-8?B?TUlldDQvQW5rR0RzaW8zbTU4LzFzNEl1OTZwZldzakxQRkJ2ekJNUmJaelRC?=
 =?utf-8?B?YmpWNnlBOG5qL1M5QXJPUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWZBMWY0RENmV1BTNEV5MDlEMll2d1EzMktJRHpIbmFRVG1ZUFhUMU5aeHpF?=
 =?utf-8?B?clpFTHlkRGN2OHBpSFdaTk1yYkF1dWFSZGpQMWtoMU5JRUltY3BIRkJLYVRk?=
 =?utf-8?B?YVkwUWFuSlZhOThEUnBLRFBIR2owK3dSY3kvWVVEOU8rT050RGRVd29ESjcr?=
 =?utf-8?B?SmFBc0tEZ3RrUnhFMHhrcktPNHFZdTc1RUpLUWVmNnNwb21MaTRvREtzWHpI?=
 =?utf-8?B?YXY0RldVQlZxVUN1dGI4TCtHSHFXZndGd0FVQmdSUlJ3cVZpMG5NaFJkcExG?=
 =?utf-8?B?RlhMb3hGTEpDOTAyTGJ5d01lUk81T0Q3bWFEQjI1SGc2UHFnSUpoSnB0dDZY?=
 =?utf-8?B?Tk5DNTJXTzNsSkJydDhISng3OXEwWWJ5dFVzMGFKc2dkUGdCZzYvOEI2aVFP?=
 =?utf-8?B?aU83M2p0N1ZsQ2hBUzFBN0lSbDBhVXBVNjI0ZHFBdWVTN29tcklDVVBiTHZi?=
 =?utf-8?B?cDh6SGZsbXo4OHRGWDhqVmJ6ZWo2VGZqSU4wTE1UUmZKRFRzZlVYVSt0TUox?=
 =?utf-8?B?SGl5N0xLWkJkOHRmZ2ZwVFl1TG9hbTF1RVZSTjFZVWNhcUJ1SnhOZ25BNkl4?=
 =?utf-8?B?dkhld0ZQQU10eWNOMk5oWnR0cGVVbWRxWUdLQkpLNTcwQlhmV0MzM3Q2Vkx3?=
 =?utf-8?B?OFVycEd5WE9SSjRvekJJVTdKY2ZLQWRKb2lmbE8xc0JhK3VWL3cxVFhpWjZP?=
 =?utf-8?B?MWZMZFUya0tuK0srRXI1WlNMQjAvblBGVTB5bFdwZm1yNU1sUGwwQjJHZ0ky?=
 =?utf-8?B?OHpGSlZNV1pDSzljOEEwNzhWU1ZBYi8ybzRwSGc4QmZUVXVCZFZhcXoxam5G?=
 =?utf-8?B?TnQxYmpRUkJud0hNZFpJWmVEUG1sVzFvQ0hmOEFQTFZUeXR0eHRaUzRRaHFo?=
 =?utf-8?B?VXVTZXRRL2pBTHdrMERSVTJkbGUxS2J0Tm9wSHpkN25sS0RQOFhWUkQrQi9G?=
 =?utf-8?B?czRuQ2FSbU1HVldGV0xXRWVhZEc1MDBzUlRCekhVVUdYcmtDSVpIYmdzOHFa?=
 =?utf-8?B?ZUFKZUNEa3BTN3JiTFdrdmlxRFFlWmxtRU1XN211ZDNiRjMrckJUNW9LZWxv?=
 =?utf-8?B?MlYzU0x2Q0dFamdXV0F4dWRrSW55S094WlFNUkZrcVhVZ2JXWHZ1VlVtTk0y?=
 =?utf-8?B?ME1vR3pJRjRLTHhNOXZQc3lwOElrN3R2Njhhcjlac1IrT3JHTUE1U2hMQ0RJ?=
 =?utf-8?B?eUpqU1Fmb3UvZWN0T2JweWxqWXVUNHl6ZVl3MVFiSVlOT3dCWVVrZDZ5aFl5?=
 =?utf-8?B?akdSbmhMUzRUeVYvWVFKc3pyRTBWT08yM0ludC9RQTQwZHQ2cVBQUVFGK1Vo?=
 =?utf-8?B?RkUwdDBBNGtERHFkUHVRb2NvM1c0YktGbm1tSWVZWUxRYzM1SjJFb0hlVHRT?=
 =?utf-8?B?SE11NjhvQllGUlVoL0M2K2J3eTZJcW9uN2s2Ykg3TVcvY3pJUUhyV1ozcEha?=
 =?utf-8?B?Umd3T0wrSG1xV0N3NTd0NDhoZ2ZSUm83eTRzcmFQYWFtVkN2SFJOSlhDYkZo?=
 =?utf-8?B?cDBaRWRVWERMUTdwTzZUTUlwREd2L2JsRW9GZzNJSEpqVTQrNGIxaGxhdW5F?=
 =?utf-8?B?c2k5NGtDMEkvRXYxeGd2VHNyZ0c3dEdkaGk5ZXcvVkJQa3dYWE5iWE8vcmRN?=
 =?utf-8?B?N2d3VHVzSTFNbkl4bFRKNjZ0a0FLbWNuYjRESE51Z2ZYNCtkWkdYQXRYRHZs?=
 =?utf-8?B?bzBaN1JnSmRPL2lXWTZXSTBnZHdLdmtTeVZXbHZQTDhFSXF1cEordWhXeWxn?=
 =?utf-8?B?bVUyZHVYeGhRSzRub0VQWHZDMzF5T3o4ckZ2RkRWaTZ5TFUyclo4eTdsRTBS?=
 =?utf-8?B?MnR2eGhIVnNOckdTRU9EN2ovaDJETjZFMG1SNkVZM0JUaGkzWjlDdlUzOFMr?=
 =?utf-8?B?TU1iSWJ4Zk1VQ25qeGlRRFFNblZqdWJEcjdPT2UvT3pzRDY3TXlKZFRaY0t4?=
 =?utf-8?B?Zm00NWhkNmxxQWtuQ0RnaDhBdEN6bERHdXRna3IwMnRmc1d6bkYyMXdrRUVv?=
 =?utf-8?B?S1VUZHFKQ2ZWc3EwSVlmVmxuWXpsUTEzSmZuSEpKTWlpV1VzankyRXRKSEht?=
 =?utf-8?B?RVpSekNrQ1VKUW1Nam9kaDNndTkwV1VXVUUyV0hzUVV4YUpLanRuRkh3YjFh?=
 =?utf-8?Q?ibHfVL1cIPZESP1jn55dwA5W9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963af0cd-1c1d-486f-6c90-08dca11d6718
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:18:03.7236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5LvLOmFmBbXuGGf/5eB+7ph9bkBnRzV50y7OwEs/ADnXZ6y7GVOZRfJiWGrmSC8HtYjl2jkrKOtfmHYmua9YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886
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



On 7/10/24 4:12 PM, Marek Olšák wrote:
> Can you also increase KMS_DRIVER_MINOR with a proper comment in
> amdgpu_drv.c, which will be used by Mesa to tell whether display DCC
> is supported on gfx12?
> 
Sure, will do.

--

Thanks & Regards,
Aurabindo Pillai
