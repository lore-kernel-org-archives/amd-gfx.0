Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1019CCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC1FB10E76A;
	Wed, 29 Oct 2025 11:28:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2gjwmPgL";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F6910E76A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXzmTJS8QihMRc1DKfhMT5BrDsFcWmCzvU6LXE9KhYQG45/kMFZHh/nd5DQkRuqkN+Hkwxre9dM4Iw6yodxsVx1Owne+JsZTJhLdsdKOIhc8bEyLtdVd724WKJhRooBj2WQM1agKN+PNOgQDxWxeP7r5Mexpycm1r6AI1hYXB2cjrDty5NGMQXNtfhuscWrXKtMx1N5TtVwHY1VJmgR/a5NulhDRPc48tmI4rSYZRW/teX5ZENKJOa2DhVlwMb/TOHOJIWqnjothXsMd0HdwjEBOSrinqjtrQzOIeTbGWhR0rVdSPvFU++PNH39sg98rj9BZxLCMkUX+rt6miRpa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyNSX7IWFHHZAZgFV3STJy+JOcjCjZWQAQ2R8pRWs1s=;
 b=o5vZcg3p6IZpySE/86QJzE3POc6H/s5WPJSRbq+SBQXGueJpqXqx2HurmCE7WGlX4pYhs9M6xDpjp5uHtEYPaPsoRz2jYlMZcBpaDYuXDRmfdY2AbJQ99azJbO2UE73jPpO80HWOvQ1Cav0uJRk7nLQlfZISJI3+5t7SOTg8zFEsjaUjiwPJ0RgbEWz9zrm+HzUt9bQ/xVrJgQ7ZcZzJY5bKgyK8aPaXGQyhUSHQenCbTrU1IkHw56j8jBQa7VKIosmjjpRghyK/8ID4fUIHDF9pinAmVhsydGEbpXSZ6gvr4L6WEReD4qDDnXT2cuTwTl7Yfc0ly/EtyjPfhQCDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyNSX7IWFHHZAZgFV3STJy+JOcjCjZWQAQ2R8pRWs1s=;
 b=2gjwmPgL8n4ncZXd5Hd/GFQpJ7Q2etAr0/kqaabGhavpq3QDXbSSaZym1evf0/zkFeQ1ic7mAY2IyfABz8cGNEa8YxK2m/ue1Psp6Iu5k2kyeYTzZ5c4epINmhpt57Fk08VdhSwbqE/1HJqvvtqt/k3rV93K+XVcOKer5veKd28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 11:28:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 11:28:30 +0000
Message-ID: <9153a014-0c4c-458f-a9bd-bf161e138d1d@amd.com>
Date: Wed, 29 Oct 2025 12:28:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] drm/amdgpu/vce1: Load VCE1 firmware
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-10-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-10-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1e9c8e-a3a1-4a73-0e38-08de16de4945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFh2K1dubTUxaWVkQUQ5N3FEd29WRlNMK1BjQ0NKNGJLNDg4TUNmR0kza2xV?=
 =?utf-8?B?RlEyemRKZFN4a09PNWVQb2xZcmkvL2JmM0NqSkFVOFRYZy9DTUM2YVlQZktr?=
 =?utf-8?B?U0x3WlNXb2RnUHJOYzdiYjF0d2VPR3l4UlZQdWI4U05ibU5mcXZDOGhUQ05Z?=
 =?utf-8?B?b2d2WUNwSldHSnRyQjJxTGlhUEdrZnhkbTJ3dnlSK0VFL3NUb0lNT2FGYUpP?=
 =?utf-8?B?RFdia2RaSDR5eG0wVkpacTQvdDN2ZUVMUTBNdWFFNkQyUXhJaDg2OTlBTTR0?=
 =?utf-8?B?STY3OHdUQjFzSENtaWl0MjFuQUs2RU1LdjlFakZmRmd2Smt3R2pzNnVBbWhZ?=
 =?utf-8?B?d3VWNHpmc3pXSnNuU0tZYVdSQm1Gd1hmVklGUmZFbWk0OE9NbUdHY2Z1a2Zt?=
 =?utf-8?B?VTB2SzROMkxPdVcrZzk4UDdjVkxodFN4ZkVhU09RNzVqT3pJUVlTNUcvYWha?=
 =?utf-8?B?VitXUzN6K25JUW1rK0ljSG5iREZZRGdDR0srQmJ5Q3lNNFk4RXh1bHJ0WGJL?=
 =?utf-8?B?YkpBY2tIdWlLd3pZNzUwK3N5S2pKUktLbm11OUc0R2VCdlBmLzNOck9DVDh1?=
 =?utf-8?B?dXYzNEUwYWwxR1hTVXd5cXQ3ZEJ5OXRmMlZ4VjJBMDA5bi9ibGpydkt3TUNu?=
 =?utf-8?B?c0RNS0lrZStHNnBKaXRra2YyQXZieDdEQXA1RDR3cnJjK2U4dVFsbEh0YWdV?=
 =?utf-8?B?Tmd2b0FCaXcvZ2FLY0M4eDU0TnZQMHYvUkU1ZWczWXBJN0RUOTlidzdlZnkx?=
 =?utf-8?B?RXIyeUxlZWtrRlFVUkJTUzVQbXFzWkVZZDF3bkkyUi82TWJuYnVWcEF3M1hR?=
 =?utf-8?B?OHkrUXBtbTBuMjh6MVd0UkkvaWV4U1NsSWxoQ1p6MUVQMHZBb2hhRWExbFlF?=
 =?utf-8?B?dEhkdFNBa1BvRHBRNDdpb3lDWEVTdU5UNmI3RXVvcW9MOS9hVm5VT2dOVmhK?=
 =?utf-8?B?eElnQ3N6VG4zRzBUOG5NWEpCK2RkQ1JFTHllekYzNldoMWlBWlBRUU1TTXJw?=
 =?utf-8?B?MCtwTkRrMW4veFNWam1oNmcxc0JsbUxWWVJ0L3VqVGZaYm1yRGppUUF2MzMr?=
 =?utf-8?B?SGo3M2NsOUJ6akdDUThQb2V6d3ZCYmlMS2piVDIyZXpmbGpPWm5XOWVKYWU2?=
 =?utf-8?B?N2xuMmRkZFp4VCtveDA5bGcyeTNScW5RaVAxTGtWemUySU5EanNHSzdSVm9y?=
 =?utf-8?B?MlU0U2RQb2lkSU1PYzd2OERtWXd0WUxjRWhYVC9GcDJodGN5UnNVemI4bldy?=
 =?utf-8?B?T0NzTUtkQlZUT29ibUQ1TGNJbkhXd2tQMFpWODZRdHhXRnpLVXJVRnJzR2dJ?=
 =?utf-8?B?dFE4b1A1TnlQOHhOYktmeTJhK3ZXMkdrbS9QSGl0RDBwU0V6N0pyZnhWcGdJ?=
 =?utf-8?B?Wm50NDZRSjR3THI1RGxPemdINWQyaTMzOUtqa3RHelljVWcyMlVVRGh2dnpJ?=
 =?utf-8?B?d0FrZ3VybHl5dFY4RjJDN3JtUWdvWXZ2Q0thWFpqWmV6Z1FuNENVVHFISG42?=
 =?utf-8?B?T3lpVFgrWWhPVTNpTWljUGJWVTUzQ2dwNmNnQVcySkNEN2s2Tkx5bkRxaWY4?=
 =?utf-8?B?SHBHdytvZFhsQ1hiNEFabXNFdXVaUzQ2aVh2cVNyK00za0o3b0xxS2hPc09B?=
 =?utf-8?B?T1I5TGVhK0RwY1lDK3FSRUNqOHpOOTliNG5RdWJ5WEk2bUZiSTFjUW9WU21k?=
 =?utf-8?B?eVArdmJHTlhkdGo4Ly9KNVFjYVZzVmJ3V3c5NDdJM3c5S3VGYlJ0Q2dkOC9n?=
 =?utf-8?B?ZFZlYTE1TFNSM0xueGVySlVWNGZTV3A3T0EyWlFITEFlOWxSZ3lybVUveUpy?=
 =?utf-8?B?UUs5ZW5oeE96T3lYLzN6QTRVZXY3NkJOdmRTNnRkc2NvUEhMVy84Z3lxVkY2?=
 =?utf-8?B?TmE4UlVqSTlqWlVjVHFycXpBMVVJU0tKdHZoR0NINW9aZ3BlQUZyeDBGaDB4?=
 =?utf-8?Q?+9yzRZGQj48d9YNlWBOnKYia98Et0D9w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJnTlVWRm5QaGg1c2ExQVlhbExJaGdsOVJyMXlPRUNkVy9wci9vU2gyQlAw?=
 =?utf-8?B?NHM5SnhDWE5ScDZXM2M4cEtVQW1yNnYvK2l2MzFQQ2pBVGdqc3VVcVRyemw2?=
 =?utf-8?B?TWlrMTJQWTB2N2pSYXJKNk5Gb1FueHhYZ1F3dmNUNXk0M0hBcXAxVlZCNHJw?=
 =?utf-8?B?a1VIMW9BVWpkVkppczNDeWNKOFNjVlV3cmtpM1pDRGVvQzNWWlpPSWxQRWp4?=
 =?utf-8?B?VjdreGFWbHQ4V1VEZGpFWkFUUGRBREk4V2RwK2kyOENVMjRzUXpiQmU4aGhM?=
 =?utf-8?B?cFFtSTVwVm5PSitUUUxXQVJxZDNESUg0OGRXMGZYZFFVV0xzNTU2a2srcVBx?=
 =?utf-8?B?T1dRelpRMTE0SjU1dXluZXdNL0pEZnYxb29xeFZxcGFpM2N1QWszcGVVUlhO?=
 =?utf-8?B?aTBwNlg0ejlJUitGM1IwSTBRZzcxWTZqK3ZZb29NZG9KZzN0eUNMdVJHbTQ5?=
 =?utf-8?B?RGFkRzRtUWNQd3RiMk1PZENEK2FHY2d3T3RpMU5RcGFRdlMvL2JhV0F5cTNu?=
 =?utf-8?B?QXFBMk5DMEZmYnhZcW5NbTA2UXlVV2tGemMrU3djalQrMzlmSGQwWW9yZHcy?=
 =?utf-8?B?YUEvU3hGSG42dkNlZHVIV2JtQ1JqcTNPK3crRnRVZDlUNUxMTWQ3SGswcEpQ?=
 =?utf-8?B?V3hRWm9uTjJuMzJJTUlQK3g1QUZKTjhFNFFURjZrb3hEUVNRR0gxU21LTjNt?=
 =?utf-8?B?NURaRXNLdmMvWkhkY00xRkxuSUlnb3Y3UklwYmJxQ0Y1a21zWW9ZQVRXdTFn?=
 =?utf-8?B?TEdWVnBEMUdidHUzWmg3L2QyNlI2L2JIampIK0ZlWnkybU5zVUp3Z1VxbnNs?=
 =?utf-8?B?WTVKbXhLM0lRVUpoSm81U1dFTjE5L2J6V1ZSOS9KK2s3QUE3Z0k5TnFSUE9E?=
 =?utf-8?B?cE9NV21uMWxybTdiL21MeFhJUVVHM0J1TmwrZ0c1ckpFSnVtTFUvNEkyQ2hL?=
 =?utf-8?B?M2Z3TmxZendYMXl6bEFWRXQvamh3TjZlaWFZbUNPRTVGRS9HbmJQNmZEN0NM?=
 =?utf-8?B?YlRlSDF5N1pMRmh2U1VsMllSYm5VcmJuaSt0THdwY0YwYWlrU0FEakJ6U0Iv?=
 =?utf-8?B?VVMzM2JOU0dzdDJ6dWlPWjVFZlF0VXk1bTNRczJqSzdkUnMxYW9NYk5WeU42?=
 =?utf-8?B?clRybmxiRnc5QXFMK2I2TTh1eW1kQ0FtOW8ySkFiWjcyUld0Sm5WbDk0d2hR?=
 =?utf-8?B?R3UvaUUvcldZc1RkRnRUOEE5U2dTbHZBOHE4WmxsR2FpUjNucFZXT3RXUm9C?=
 =?utf-8?B?WklwUE40WTFWYWtmREhNRVpMbkxlTDRWbXJvVXlJWVo1RjFJTkc4ajlObTFn?=
 =?utf-8?B?QmZlYnlZcDJhcjVLM094VEM2eDhwT3B2UUp4Q3RORkM3dXBncTRZVU1QMENH?=
 =?utf-8?B?dFFHMnFFSTBTQ3dSWVdSNFlBZGt0bXVnMjBpNEw0THF5aDZuUHFrTnFza2pE?=
 =?utf-8?B?ekJPeXQyL1kvZmx0ZlNLbHJ5MzkvYUxNZmxkVFkxelhzTTVnVHVjTnZyLy83?=
 =?utf-8?B?QU9YYnRRUnBtaDFhVXdIbzBsM0xFVWtZZlpJZ2dWeGg2cVlCbkhJUkdVMUFC?=
 =?utf-8?B?d1Fzbzl2bXFXckFIaDRnZHhJVzFhcE84VW9hbU1UNmdVZEJQQ2tYVjg2eFNo?=
 =?utf-8?B?emxBa1NteStxQ2Job1p1dFp6UXFSTWl5ditoajlWbitMN0RjWFRqSTVUSEEv?=
 =?utf-8?B?c21Sa0EyQkxqYThBWjV0V08zOHJyYlhYVExITGxtWDlwTWRvOEplT0VnQ2lj?=
 =?utf-8?B?cVB3UERDOGRienpTOUIvRTZkdGt1Z1pqVjY1b0lLTFRBek9sZGxtSW42NlhW?=
 =?utf-8?B?OThhSVhuRkdrcGc1NlZhVEpGVXhUZFI5eUtHWkZlL3lvUmg0dS92Y3ZrL0ov?=
 =?utf-8?B?RWYxKzB5TGI4c0J0eDNIai82UkIvQm9TQWxvRWZ0MkxsWC94ZDJKSXlNUWZY?=
 =?utf-8?B?QTNuU1A4YXhrWVM5Um52ZVVvQ2FPWmNBb1pIZFZUcStvNlZlQndOYU9uQnlF?=
 =?utf-8?B?VTRMZyt3bkJuOGN5VHVJdWNDSmZJK2VKdGREMXZha1hIUmoydm5Bd2R1SytD?=
 =?utf-8?B?eWVqSndzdGVEbTBpT0cxL284Q0NZUUJhYzByWWVwNnphaldFVVVTdWVNSHV0?=
 =?utf-8?Q?UhNdo103V3bwop5wVXpoG4ZFG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1e9c8e-a3a1-4a73-0e38-08de16de4945
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:28:30.2791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6aORbqrWTfgSRAWcfVrLJNVs3qKSEst6lLv/SYvuaEzOQ9Qz6gnLZKqz4uLqVER
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054
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

On 10/28/25 23:06, Timur Kristóf wrote:
> Load VCE1 firmware using amdgpu_ucode_request, just like
> it is done for other VCE versions.
> 
> All SI chips share the same VCE1 firmware file: vce_1_0_0.bin
> which will be sent to linux-firmware soon.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Co-developed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>

You can probably drop Co-developed-by and Signed-off-by for me on most patches.

Especially this one here is not really from me but Alexandre.

Reviewed-by: Christian König <christian.koenig@amd.com> for the patch.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index b23a48a1efc1..7fcc27d4453e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -41,6 +41,9 @@
>  #define VCE_IDLE_TIMEOUT	msecs_to_jiffies(1000)
>  
>  /* Firmware Names */
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +#define FIRMWARE_VCE_V1_0	"amdgpu/vce_1_0_0.bin"
> +#endif
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  #define FIRMWARE_BONAIRE	"amdgpu/bonaire_vce.bin"
>  #define FIRMWARE_KABINI	"amdgpu/kabini_vce.bin"
> @@ -61,6 +64,9 @@
>  #define FIRMWARE_VEGA12		"amdgpu/vega12_vce.bin"
>  #define FIRMWARE_VEGA20		"amdgpu/vega20_vce.bin"
>  
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +MODULE_FIRMWARE(FIRMWARE_VCE_V1_0);
> +#endif
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  MODULE_FIRMWARE(FIRMWARE_BONAIRE);
>  MODULE_FIRMWARE(FIRMWARE_KABINI);
> @@ -99,6 +105,12 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>  static const char *amdgpu_vce_firmware_name(struct amdgpu_device *adev)
>  {
>  	switch (adev->asic_type) {
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +	case CHIP_PITCAIRN:
> +	case CHIP_TAHITI:
> +	case CHIP_VERDE:
> +		return FIRMWARE_VCE_V1_0;
> +#endif
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  	case CHIP_BONAIRE:
>  		return FIRMWARE_BONAIRE;

