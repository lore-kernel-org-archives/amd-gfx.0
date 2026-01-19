Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2F2CCF2F2
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 12:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2014E10E41F;
	Mon, 19 Jan 2026 12:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pZ5tav6c";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78E710E41F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syR0FSsjrB0qXZqVKJJqKDl7C6zAf1KHMZrwjLYRZcjJJ5LnCu2I+IcGtXy7qhtglghCAnBopMZ3HcYxvaomNRje7geYwas9hKuK03kNLeiVSZbXDY07MynpmPKRV+I2fqHwJuSV+Vhe709YLS8D+HVUu90pJ+8W10E6VeQOjADdg3oEmHR3c74EOQ3Tm6SRg9Lgr2VngwhilzTT0np8HkT0oxG2GNoASBGm9ThwNiz/kh64JTCOHNUxY+CwAv3kc56oSL12sIQBXXOc+ePJm4LyJkHi/790/mxZq/Y0vP5bj1s7Hr+AiYFQPszaWSTnhRzb4BRKf0W8WKfmVGMW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFOEgNWdkzjgX8TfaZuucsT8Egaf8buAOMhbtE9G8A4=;
 b=cGeKwe9ntgx3KjQYQHSKzj+T1qPsdszpzREI8+L05NXZNQ/4MsnIYWgeiHlff0drlcHaDwqcED4FnEnLjmbcNTEhRk+qytzjEixenD73jtL0SNCqGPBBAx3EZyfiT6lZhr55xjhLTTOxC7sO2jRzMId6+mJVDQQStMqNk0LmdJTR7Thnr5AeChhHjOCpWxnL7Bur2WqwMVvnvNq8G75u47w2ihNax/58M4PZOgi21h0Q4Tu9dusUjU+irVv7TVuBznn618oFEmQGkWDevdoivuK2NdlEoIGsUa0waZrzmCq0S9Hs6Mw2wk9gZtwJS0Aw6BZfplTuuUqUUZ4r9tMAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFOEgNWdkzjgX8TfaZuucsT8Egaf8buAOMhbtE9G8A4=;
 b=pZ5tav6cNYkQ/x8so8ruPb2dcENojsaMsmn7dPWjMG9Mzy7WNpS+GrPYD7G7KPsLGE+KI7luDaFt0fVnNo6dFSyyAeCs+AuPIOKFZBsvLrvjw3nGBGa5a7HbOe6ILKOtXmgBjZN5t7nWRGydZSpgdi0jgxAu7nmx4B94kuZXd78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:22:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:22:54 +0000
Message-ID: <431f6539-122b-43fa-b531-099273bc3684@amd.com>
Date: Mon, 19 Jan 2026 13:22:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drm/amdgpu: rename
 amdgpu_fence_driver_guilty_force_completion()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260116162027.21550-1-alexander.deucher@amd.com>
 <20260116162027.21550-3-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260116162027.21550-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: f374ea6c-918d-461a-22e5-08de575578e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTYvN2pyVW41eVQyeEFjUW5pa2UyZWdwblBxRTRqVFNnM3JKZDIxaG43WVVl?=
 =?utf-8?B?bHhQVlNUUUpRWnF3b05yKzVrQVBxUWJ2UjJleUtNbS9JMUxzSTJjTGVyZU9M?=
 =?utf-8?B?YU5tYkdWNVUvWHNOcng2RzhPT3ZwMFgrRWsrd2M0dWxGYVovYkM5eDYyOGcy?=
 =?utf-8?B?QjAxVUowYktheFQyQ1Ezb2hDRGIzMCtqUmVsSFFVQUR3cHRlTU5PMlN1Y0NI?=
 =?utf-8?B?Ly9DV3VYT1BqZk9NZ2lyVmdLRmlUc0dHUHNoVU92ZDZ0NWpFN0F2bWp5WHlq?=
 =?utf-8?B?MGtQai9mUkplNE45UlBEMzRIQXlISy96SXMwNjl2aWE5NUthbTdtS1l6Tklp?=
 =?utf-8?B?Z0d2OVNQSDRUL3hBbnRRZE9YZHVmRExGc1hDVWVVdmtCQUp3OGNQa3BtTkJC?=
 =?utf-8?B?d3R6TWxEUlV0WlgzamdaSGtOSlNJRGhiQ2dvZ0VFN2Y3cjlxNFNsZEFxZ3Vv?=
 =?utf-8?B?S3N5cWs2S09xOWkzcy82MkluNFNtTmdZcERSK3hzTHE5NEsweDFEdlpTM1Rj?=
 =?utf-8?B?bzEzcjhnZS9iMGpzdExuRHIxbnIxNUcyZHZaMVgwMkNYTUlrTTJtS05iV2ZV?=
 =?utf-8?B?N3NIeWpmWGFQcjE5RS8rdWZmWTl1M3E5cnQ4M3lPTHVRUGkydmhjbWJ1ZXhq?=
 =?utf-8?B?RjN2U1ROdkhLbDNOUVoya21tYWtFSG9BQ3czM09MK1JITVVaYWlkSnZSNmpR?=
 =?utf-8?B?QU5tb056d21wRVdmKzJsOHR4VzNncHlETGN3VldwZGNUdDhUeHlYM0ZBclpi?=
 =?utf-8?B?QVRGa3dvS1MrUG9LTHA4cjMycUk3UnVpVFY5K0paLzY4QXdqeGRBRlhhM2VH?=
 =?utf-8?B?MjVhNzhVL1ZzSXRiUUJybVdEY2YxcG9WL082eVVIYWcxRnVZVWpoeW1wREds?=
 =?utf-8?B?UkkwYTFKQ25DcEFaS0FPaXp6M2o4L2VjUlpqWVJrcUhCZk1hT1M2UDN4Q1h3?=
 =?utf-8?B?ejZRZHFBQnNNaDJSS2ZyOGVqWXhVdTE4dlN6MSt0OE9ET2cyZGNsNlBZSnZN?=
 =?utf-8?B?czlHbTk5TGVyRzNpekhFMEYzbEp0SGtqdHNvL0R2enZ3NG9FVlNWOVRkUlNz?=
 =?utf-8?B?MVJraG5DYy80ejhKUTloazAybDhNTkVzZGRtUVNmd2JnWTdPRFJRS1pxTkdk?=
 =?utf-8?B?cVhHMk1KeWVheC9KT3JWV3N2ejhQdzBzTm1lL1AxNmI0ZCt5WDZTMWVGN05Y?=
 =?utf-8?B?T1gwQm5tQWxFSURJT0JYbXk5YW9lMkg4R3BuMEc1N2FHaGR4ZUhabmRJT055?=
 =?utf-8?B?UHlHSlQ3YjNkSkJpdmNPdkNKMWJtNDRKbll5US9MNGt1VVpTaUxwRzJlWVVn?=
 =?utf-8?B?cDYwRzNTK3U1RGJrTisxdTY0b1kxU2d4YWI2MUdKb1lHK1BzekZSMFBEajhy?=
 =?utf-8?B?VXZmUkFVWjFpc0pRZkJpdjBSb1NhM0Q1anRSbEFCRjB1VHFvL1Nnc3ZkVm9Q?=
 =?utf-8?B?T2VNNkFidVdsNUxlNUxwN3doRU9MS3pIaFpVWlBHb2pjbXU5SXpiOEQ5Zjhl?=
 =?utf-8?B?TVpsRjIwRlh2M2QzYmdlalJUK1Q1RkphNi90RlRObEtFeGV4aUFBNzlhc2Qx?=
 =?utf-8?B?QnJJK3ZYVFZnWGZvMjMrOXgycVd3d25ZWUMwczd0TVlGdm9WSDBxYk9YUmlS?=
 =?utf-8?B?SFBvYzRhKy9Sano5cFJKVUt4cXRJVEpiUURleTZaTkViMEhUT3A2aGNJWExh?=
 =?utf-8?B?K2NoUHd1Y3c1aVVYMUNaVU1KU3RmaGpqMm1Xb1BuK1pwYnBBclZOcjUvVHZJ?=
 =?utf-8?B?T0tTMExweHNNY0pTdVEwbmFXWWtUZE13eC9DNWw0bWZGQUNTUGxtOEw0Q0Rs?=
 =?utf-8?B?UGJxMm5iZGw4d0o1RU1kN1dOK24wcXo3ZzdpeHdnVDduVE9TS3N4OWw0Tkph?=
 =?utf-8?B?cXZ0QmVyemx6RW1kNE5GekN1elRwVU5EM2YxbUtJSkpuM0ZZVm5ncGtiNVRz?=
 =?utf-8?B?SWFGeUxNVG10MlBKRFNJeE5TOWJGZXRhRDZRd1NwWXRrdytpNzhOeDdaWkhO?=
 =?utf-8?B?Q08xVWF6S2YxcHpwT3hXZ1EzOFlDUjd0TDV3NGF6MEJ5YzRrdUI4OCtsVGJD?=
 =?utf-8?B?UVhMVExralE5U21oVTgrQ3BSZGRXUTJzT3lvWEhPcFRNWW5SSjNOT25QMVF4?=
 =?utf-8?Q?f/jE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmlpcjVyOHBzcnV6d2tBMXEyQlduYTJxTnhMVGx4WkhocGV0c1FOOHFNVzlQ?=
 =?utf-8?B?UkNabHRwaUNwQXE0aUdQMXBvR3RNaVFOZWN2MkN3S3Y0MFlNQ1d0TFZpSnpz?=
 =?utf-8?B?ckwyUGZPb1FPWUg5RFRlNTVhSGJoZjdISWVEakdUR2EraUNrc2k1Z2J0ZmdT?=
 =?utf-8?B?eDRrNFhyL2xMdi9LUWwvVlJCSWhwUWRpMVhDS3BJRDdGcXpBY0ZxbTZZYjNO?=
 =?utf-8?B?WGVmS0NqVm42YnptS0l1NjVWU21ROENOMVZleVJzd094WTNjRFE3KzBjQUt1?=
 =?utf-8?B?U0ZzQUpremdSUjNwTUlJSlhVUFQySy8zWFJaQk9ORG5seUxZQzBmd0RvRDQ0?=
 =?utf-8?B?T3VOS0h6eC94NEVERXUwOVU1dE5nMzcwT1hSbHdycDBrY0FOVE1NRG5JWEpQ?=
 =?utf-8?B?WnQraE5mbjBJWkhrVWxwYVN6N0EyYzBJOEwwVmVrWHRFckExVjBWZ2J0ZHNI?=
 =?utf-8?B?RW43T3JkdGUzcWx2TGdKeStnSkVITHBOcU5JWlZIMGdFWjNpNDZPTHNHR2RP?=
 =?utf-8?B?K09rOHBxWjh6dVVpTXBSNGRyZTdHWGZwSlhoRjVLRFNEWm5QY1liVmEycE1w?=
 =?utf-8?B?QitmK3BkNDdlaUErWmZERmhVSnVTcVZYS0hoMW1ObEFkK1c4YWQ5NXdPS2FR?=
 =?utf-8?B?WVZLbFJOOEZ3WksraUw2aTFnWUV6NmtJM1Q0N3U2Q21vRUUyQlc3dk9zNG1J?=
 =?utf-8?B?OUM1NHhkWlErV1JNN1FtMjQ3dnN6cHpKQ1kzWXBLRDNRTVozVWFsYzU5blhO?=
 =?utf-8?B?ZlpqZHQwdkVGaUx4c3plemxuL3BaazY5Qlg4MGpXb0NtRisvUndXSVdUNjc1?=
 =?utf-8?B?TVE4bnhyMnlDbDNYMC95bVpuNEpiMElVVDFPaEd6cUpNVUN5R3VwZVp6VHNi?=
 =?utf-8?B?bG8xL01yNDg3U08rZmpGTTZMTy9GZ2trZXVqVFNxUXM2blRTQjRRbTFWNWR2?=
 =?utf-8?B?VUNhY1p6dVUrNGRNM1d1K0RwbVAxQlR4a3JWcXRDeFUyTlhZYXRuT05DTWxx?=
 =?utf-8?B?ci9SOW4zTjFXeXVDNmFLRFdYakZaUnpQTENKTXlvRDJaT2MvNks4Y3ZKQkpV?=
 =?utf-8?B?YjFhbmQ4bmRxeGpPL1Y1eUkyRENJcDEvU1Y5eHZSa09qR0xHTHRKQmI1UUg1?=
 =?utf-8?B?aGtlVTFVV1ZlempRZ2xsSDN1UnBCdmRRdmIrMTlhTnlGcEV0OWZyVUh0UDdt?=
 =?utf-8?B?Y2Z4MUhJSXd0Z0c5RG1hRzllWSswcHB1YUMzcmtsR1Jod1FsWmY5a1FxdzhP?=
 =?utf-8?B?U2c1MERyYjJ2ME1CQ0VuU3Y1bUNuQnhnZjl6UXI0MTlEeG93TFdTa3NZMVZM?=
 =?utf-8?B?V20vYU1XcVpCMklSNzVPaFFtY2MvSjk1S2hkUUtlcDRDaDYvbnVTRzZwTGQx?=
 =?utf-8?B?cU1ZOFNoNHBoU1A0bVVBNFZtdDRCaXVJbHZ6MWlLbklHdU1FMi9WY0JiVndL?=
 =?utf-8?B?UWtTdmxMR2JGekRwNndxOFc1Nk0xSVcrQ1NTQ0hlalFFMWVOMUsyYUxvQjA2?=
 =?utf-8?B?UEdhQW1TczdDZ0QwNmFkb3dZcEF6YmFjcUVMWU5ra0V0NGI5Q2lCd3d5Nk1R?=
 =?utf-8?B?aUZGYVIwdVoxd1NtYzUxN2tHOGdLUS9ybjBGdmRrRnMyRTgrc2JtMTBtRGlp?=
 =?utf-8?B?NXp3Uy9jTzZNN3QrRVBYTCt6Y2VSTUJoQUlHZytGZkd0dEtteWs3SVp0ekhM?=
 =?utf-8?B?Mm9CTzQ4QllmaW9LWW56SnBtZnZPa2creFB2cjhWbjVYa2FXaGlhbTd2d2hz?=
 =?utf-8?B?MERwbzUzR0dTbWxpei9wOGxCVmRTY2ZQdDYzMzhqS3RRa1VXQ3BrLy9UdXNZ?=
 =?utf-8?B?VjJ0Y2RqOWx0YXR1OWd0RzYzL1BCcDFRTXcxQzJjNTJQdFp5U2w3STYzOUJ5?=
 =?utf-8?B?TGp3WWdFSTRuRzVod3BuR1B1cy9IQ0liSHhZN3ZZeXY3djkwN2FiMGI4bnho?=
 =?utf-8?B?UmNXV01LcEZjb09EcnUvWGpYZFVNa0xRSk5VYTYzTTZlc3d1YkhlZUNMTXJj?=
 =?utf-8?B?b0swcHlzUGMwQThkRVIwdGVjZU91aHY3ZHdKNmlEdDVSS0g3U0g5YjlhajVE?=
 =?utf-8?B?NUltOGVKSzdZMGJVSllpeG9lR1AvaXFVRnFjZkxWeHF2YWtIYzdSS3NhRmJX?=
 =?utf-8?B?WGRnb0NVbDVVTzBXTUFuNDV3R09xQ3BBZ2htMnpwaTh3aDJuMXcwbzFRUk5H?=
 =?utf-8?B?dE5mcm51ZTVKSmYyKzRFbmlwY2taUU1FVW5BTGoyWFFDSjJMQnhrYi9YSUFQ?=
 =?utf-8?B?c1lhdWhvR1ZEWHNQdTFqZXNFTS9rdFhsOHZMb2hrUE5UY1p6M2grTy9nY3Zh?=
 =?utf-8?Q?LnAfy4S70zG0+j37dz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f374ea6c-918d-461a-22e5-08de575578e6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:22:54.6874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0XIxg84gV4N8cc1O6aTpNAy9UilzFoIHWhkL1tf3oss26tcCFHP7wvYtp+9Z7sM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

On 1/16/26 17:20, Alex Deucher wrote:
> The function no longer signals the fence so rename it to
> better match what it does.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index f2f0288b7dce4..c7a2dff33d80b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -709,12 +709,12 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>   */
>  
>  /**
> - * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
> + * amdgpu_fence_driver_update_timedout_fence_state - Update fence state and set errors
>   *
> - * @af: fence of the ring to signal
> + * @af: fence of the ring to update
>   *
>   */
> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
> +void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
>  {
>  	struct dma_fence *unprocessed;
>  	struct dma_fence __rcu **ptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 600e6bb98af7a..b82357c657237 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -885,9 +885,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	/* signal the guilty fence and set an error on all fences from the context */
> +	/* set an error on all fences from the context */
>  	if (guilty_fence)
> -		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
> +		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
>  	/* Re-emit the non-guilty commands */
>  	if (ring->ring_backup_entries_to_copy) {
>  		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 87c9df6c2ecfe..cb0fb1a989d2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -161,7 +161,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
> +void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
>  void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
>  
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);

