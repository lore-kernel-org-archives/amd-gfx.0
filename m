Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A76E9A03B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 23:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A88710E278;
	Tue, 17 Feb 2026 23:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Po4ME6zg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C05310E278
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 23:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVFOjM+rtbkMcAtc5A4kJUQVO0X/yp3NS7bfE+YwdeKXr1Rt8SUtPDunYNRyKzuTKxqhb/jTMN6KFsmPp+fGuid80DJxQAyq8IsZBWMWfKbZvjyQCcgx9ZlnpntYyHo1e845DsLP1RWsCb2FO9Ayun9DDM6NDOVzNpoejpoB4jTW7SHlD/T9y4f3wiEH0bQDQboqEpfU3cc+/pfZOkngzB5jmoy9DwitDBzWY76tbQDHXktkLKROxpMm1y54G3tOrwdrxwAmlD3FEtqPOYzQbiSf+PxYxpF7C8vAoLBP21+1sryuVA6vs1m/xpIyxmsX1F7hrOJ7y34By5TxuJtPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb20bVkPbxQEbyoEyyOSCbAsntW17fOib3FxaZ0YmUA=;
 b=T+nXLUR0AoPqtR2kW0NLlJN9cVd1UDvbWnDeqIJUxT2ROgvhBw9cOVsnaPYXML7Y2WYKWev/stE9UrLnNayo2J9D8gj6EunEcJynEHeIasfOUyxjr9+1wSwtin6KvsRB0zcPK+xIvaLSHHlmId8PLT58K0qmMAEqibLz1H7RYq5BwH7g8a8flnXuP7mcur9uXOXmOoOwlLl41osVHtrpUP+3CsRCUysQq04wZjs1JLZeiMSKU7L4ZGv14BoZgc7GRfrt8023/wqVeowH4WjbiIaWiJgZHwA7Z6nx8HaKjKpAjQL2qg0LE8tlmTgWbUABhWxkmd9nB/C0RT8FOc2wxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb20bVkPbxQEbyoEyyOSCbAsntW17fOib3FxaZ0YmUA=;
 b=Po4ME6zgfOdb9MA7c6y3ZN05O1KchJdnJDK8t62nHCN81dsvQohD6G4cWN4FFtw38Q20kMoHAIOBOSLDfIdpHGebB2NXqdpnnt/o1DBqnCBZzznF0y8ec59jB+7CbR33c06kpYcGXblBMEQoIlC+aMn6U6159ok3oQE17OABcOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 23:15:08 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 23:15:08 +0000
Content-Type: multipart/alternative;
 boundary="------------CMgbmXU0V2RbyF9xy6hb0GYe"
Message-ID: <40ad9d55-2a34-4f1a-80a4-e841d4afae28@amd.com>
Date: Tue, 17 Feb 2026 18:15:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix 4-level paging if GMC supports 57-bit VA
 v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip.Yang@amd.com, Felix.Kuehling@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260217100114.2019-1-christian.koenig@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260217100114.2019-1-christian.koenig@amd.com>
X-ClientProxiedBy: YQZPR01CA0174.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: ef658233-3a24-4bba-ac1c-08de6e7a641c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXdnWjdSMGx4bFpLc1BiR2c0dEx0bmJONFRRWXpUS1BodWdiUjFjRzQ5U1By?=
 =?utf-8?B?empVb3Z5Z04rQ2JDdTVMNlpLK0VlVWJoZlZ6NzFFWTVmK2FzMTc3S2ppdktr?=
 =?utf-8?B?eCtGdXBka01YR1VLb1RJZkI4TnVleFhFOEZXRlNGYVJNUXV0Nmk5QWRGWC85?=
 =?utf-8?B?UCtHN1FZeFBMK08zSndWL21aaG1FV0VZQ1pNa2pqVjZUSXMxcjVHQXRLUW41?=
 =?utf-8?B?MStMRmNpamZWNWFqT3h5U3BGMUxWSzh6ZzN5bGQySlJtK0ZDR09aenB1Zldi?=
 =?utf-8?B?VS9JaVRiVk9oY0duZ0Rid2Ric1lCcTkwODhGeG4wM3pNN2I2SzBwTWdhZFZK?=
 =?utf-8?B?Sk92K3BYeUQ1ZTQ5dWg2WVBzNlM1SVh0d0N6My9JclRZVWJNN3hlSmxya1RU?=
 =?utf-8?B?b0s2alVmYSs2bXZQT3owL1IvNW9HcUZEVXpkdGtGNEdqUlZxSTdlSWtzMTIv?=
 =?utf-8?B?M1FBUVZrbS95RzI1Q3dKekQrZjZTczdBR3NIL1grbDFqQXdQTkJ3SVlXZEkw?=
 =?utf-8?B?dllQYmswU1BGNDNBOVFRbEoraWZJbEd2ZE9XYzVuT3I3RUFuQW1sdEUxMVd6?=
 =?utf-8?B?azQ3US9xeUNleGpPbmIvY0xhV21TbzFMVnN2M0kvTGxwZFdhTmZTT2NvZFNq?=
 =?utf-8?B?NFBwbHZqRks3UlpDQ1VUVFRMcHRoQVpPKy9LQnVjUk5HV0ZlT0t5aFlrWWpD?=
 =?utf-8?B?WDRLRGdDczZGaDhjdDFwbUlhUVdFT1FpUWZxRnBXV3AwYUMrUHVSU2pGY29L?=
 =?utf-8?B?SVA3OUJVODlqczBJZnVoRURrdzBCY01nVWFGT1FrWlI3Wlg4Nk9MdFozSjFK?=
 =?utf-8?B?SStDZGRockk3T0c5cVh5SHRGYkdQWFg4dms4SjhVTFovdm9PTGNCN0tkeTFx?=
 =?utf-8?B?c2crQk1nZjV2RWN4Rmp5VzF4eWV6eG1PdWxsSnAxTWtNUDNBVlhlTXdGSnhK?=
 =?utf-8?B?dTNkd1ZQbjNiMFNSQUxpTjlwdVp6cXFmT2RYbVBLajlGR2xRQWZHQm1YMDVL?=
 =?utf-8?B?OFMzZDhGMGxUYnNCUXlKNDVQay80ZzZydnM2dVVBTUhTZnNWcUk1bzI1aDJV?=
 =?utf-8?B?aURIUjhzSWVDdlVyakxDVXNTNWhZS2VIaWZKc3RZZmh5ZW1XWnprUnpjUW51?=
 =?utf-8?B?VDR6Z01yb0Mvc3YvRDRlQ0xZVEV3dWJMQ2dTYlQ4K21xaW4zRHJJM1F5NXhn?=
 =?utf-8?B?YW43c1JUdW9QbVhTUzdvRFcxTXd5L3k0T0lqdlNwdEIxK2Q2UkZPMDZKTkhM?=
 =?utf-8?B?S096c0huTUs1RU5TV0JXa0liL1hZM25yRWFpL0lvTWtsT0FvYy9EMytQVkxB?=
 =?utf-8?B?NW5rendzeWE1anhtSzBidGpkNlYva2hGczh1cEVmMjJLT3NwczE4c1Y5ZGFn?=
 =?utf-8?B?TEllNHRqS3pZQW5paldWbnBsVlgydFVkclovVFdEcVFVZW9takpPWkYyckZm?=
 =?utf-8?B?UWFoVEY5NnQxK2xrMDR3MTMyTVpUa1piMVlUb1hPUlpOK0k2T3ZFc2d6Y3po?=
 =?utf-8?B?ZlIycG1Ba3B2enBXbjNVaXAvdjdJK0JDZnh4d3JSVzhVN2NxYjNsZUtSQkxJ?=
 =?utf-8?B?RGpoVXBQL1hBNzl6aWJpMU5meFRuaWd6M3dsSTJhL0w1RmdFN3RHWDgxTlRq?=
 =?utf-8?B?Vm1uTjkvSldRdHRXbDNuVHBZa0s4K3B6TEpwenhBU0k3UTdRVDFmTEpoeG93?=
 =?utf-8?B?QUNmOVl4K1hBL1BNa3dPR3cwSzZPV0NEMTVZaVYxVnhRc3hVNFZCTVVCZVBY?=
 =?utf-8?B?TWNYbHQ5MEdZa3VwSldHb2hSbWZiZDVrbHBKemlOQUoyQ3F5dWp2NXZSeTFM?=
 =?utf-8?B?cm91bjVhbW1yTjNDbDQ0eXZUMi95ZGRaNzFobSt1TjBCZEdDNmcvSkFKODNr?=
 =?utf-8?B?bzNkQ3FCb2J0U1kxZUpDSzQ2a1c2UlZ3MCtGL0FuY0tFNGp6RXEyU0JqemJH?=
 =?utf-8?B?dThXRncxVFo3WDVqODZvQVo5RnJZOUE3MWh2bmRGeGNUL2dsTXMvQ0tpZS9J?=
 =?utf-8?B?ZUpibkNQYlFhbmtzdVVGMjBla3VjRkZaTEpGbWovR1pGYXBqeDNmOUxKSGZG?=
 =?utf-8?B?MGRQbmV6UmYrUkp6cFk0WlBPbUpIcnN6VUNvNGFsRUF5QkxhaUxyQWlnOEtG?=
 =?utf-8?Q?oFek=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTZ1eGNEV3hBTHhoOHA3Ymh4TjNaQWVpOGtFZi85TmxGTHFkL2g3MFJMVTZ3?=
 =?utf-8?B?eWp0Mlo3V0hmMVZVQTQ0cmU4RnQrVGpMY3dwQjI3Mm91dndydytLYUpsZFBn?=
 =?utf-8?B?emVEQXVSbmErMGtvQTkydGdYbEVQczlacm5uNVFHVUMyZE41VEVIaGZQUFpo?=
 =?utf-8?B?R0xzK1E2cEVQSnFIMndaMUdCZ1NPL0NiNUlMZW42VzhGU0RGcjB5WkdncWhN?=
 =?utf-8?B?bkdqaXJubVZyWXZ4OUZyWUdjUFVaSC90c0dJOFJUSWpQQ215Si9URVhkS0R3?=
 =?utf-8?B?MU0wOWlTbyt0Z3o5SHNRczlkQ1llR00zRldjU2pnTmxWcmIvWkxHQXR0Tk5U?=
 =?utf-8?B?RnBqdFVhNG5RQW1ZVER3cUJTenVOSVlpQWU0cXVlenVtUjRxM1I2alB2Uy9o?=
 =?utf-8?B?cElmNVIxM3NCRE9CeTVvQVZGVXBxNk9paWlIbStxZXNSQTdUMnlWTVpBTmxl?=
 =?utf-8?B?bis1Q2FJcjNsVFlVR1JiakFxbVhQNUtMdUpGSkJjV2d4TlRqZW81QXpjeTVT?=
 =?utf-8?B?ZU8xdFBLRHZmWUUydWlWaEJ0TkZzZncrdHpVRmZoUERuY2ZLQjNLVThWUWlh?=
 =?utf-8?B?bTQzVW8wcGEzQlcyQjZtYnoyTjZjTEY2VFFEV3BUNFdYN3I0cUNMb1l5L2pF?=
 =?utf-8?B?NmpkaFdjWXdKRTUwTzVLWjkrUk5la1NBMk5GMm1IS2w4UHVwMWRINjFYWC9M?=
 =?utf-8?B?V3VIWlcyTDZacjJ3SGdtb1ZmajhWdlorVUwxTW1PbW5Pd0xKd1J0YTZlWGcv?=
 =?utf-8?B?Zlh4aHBmZkx1OURDUkpwamRheTZiTi83SFB4WHNnZWVjRzJ2YlcvdDFOWGxD?=
 =?utf-8?B?Zm14VGQxZ3F5QldHV091OGJXV0hEUDZxWlh1YVN5WG1pNWVVTUs1c25tc2FQ?=
 =?utf-8?B?eTVYK3pnby9sSUlDNlovYlVUcUJGMUxCSzNmWlNnQnhORkd5ZXhlV3Q1OGxu?=
 =?utf-8?B?ZEtkcitiNisrdW82a3R5SkhibzhIRFJuTFUranNLNXE0aFV2akFOT21kNHVY?=
 =?utf-8?B?aFJ2VmlVVGJsYXU0bCtQY3kzdy9nQ0xYTk5JaFozYWxlSnd5Ty9telJIS295?=
 =?utf-8?B?ZDlIZkRUYURSajQvYjRJY2RtZnBlSjBrbmZlUzQvL2V1K1E2Yy9Ha0lnUEZq?=
 =?utf-8?B?Z3RoL3dyMHJ5NDVmdzQvYVZwaEx6ZWRjZ3dSNjEydWxEeDhnN09vVWxZUTJi?=
 =?utf-8?B?YUpXL1I0ZUlVelY4WG1OalNMMGxQUlE0YUVxd0xGS3VCTDlHWnlSbGlXNld5?=
 =?utf-8?B?SkF6N2VBTmZhSSs4cFh4NnhJWERNRXFoQ0FTajhxZzVzMlRiT2Q5NGNQc01C?=
 =?utf-8?B?aS9LbHduNzEvUGZKK0ZiVlNMSGNrYTQvWEJINyswL1oyTDh4Zm8vTnl3SUhK?=
 =?utf-8?B?a0crU0ZCVzNUa2RNUXlXV01Cc3o0TTFaWUlTcjQyRkEzb05rdU0zRmd1WE5t?=
 =?utf-8?B?dHRQWnEyaThYV3FQVWUydzVhSy9XSUh6RDQvVi9WODVRS2UzV1JNVitkdTY1?=
 =?utf-8?B?OUt1VldQR0gwaldmK3lTS09SSHZweUNHdndocUZ4ajh0b0FkUHBmdTIvdEF0?=
 =?utf-8?B?N3JlMHloM21MQXpmc2xJZExGQ2tWQkRub1g1S0xQMWVwS0JWR1pldzdXOUgy?=
 =?utf-8?B?Z1NYd2IzK1RjSFFnSkkydkpTMURRQy9VNXRPL2E5bEtTK0dBeUExM2pwRnVQ?=
 =?utf-8?B?OWg4dzkvT3NNZzFmOENEM2RMcFAvcnRHSDBjQUhTbVhqR0NrcHIvREFSbVhy?=
 =?utf-8?B?VWdmZFpnOHVodDNpWk1SOVREVmg4alZEenBLWllzRFpiR3ZxaEpjVjBmNGxw?=
 =?utf-8?B?ZEJzWTJtNzk0OXV5R1hxcGxUUVE2dERhRHhGRmVmK3FJbmhLcGN5eG1FdUc5?=
 =?utf-8?B?UllUdytxc1BVa1hBU0ZvcHpoVk5MWTNXZTVlWTJld2xpWDVrZjdoZ0JJVUJ1?=
 =?utf-8?B?Sy9NUktzSE9oblF1OFMrQUJZZVFtL2E4UzF0c0ZJTmtjdTdzN2ZHMFBnRFhp?=
 =?utf-8?B?Z1o3QjlhbDVXL0NhckFILzE4TXZOQzRwYTNrUUlpVVpjd09abDA3bXFSOXBC?=
 =?utf-8?B?NzhBNjVXdEFyNU5BZmJIM3NWeGxUODk1MFNVMG9GN0tablFCcWd6VG5FRks1?=
 =?utf-8?B?ZHlrdUJtQjJHZnlYaDhWd1RJSytvTWp4Yk03TDZqdFJvdkFjTTRZNWJ3alU1?=
 =?utf-8?B?MmZ6N2lMYjVpVUtKK1NJQy9FYXhhWFA5STlnbjJKOHEvSUQvRHVnM0RxQUpj?=
 =?utf-8?B?RkE3a2VoOVcrUlpaU1ZocW5rY1hKRkpsQWxqcnhzMDVMOWU3Rk5sM2pVQzZa?=
 =?utf-8?Q?BSVRtiDsd+E5j2ZobG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef658233-3a24-4bba-ac1c-08de6e7a641c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 23:15:08.0486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GEK9aSp28ivjcr4VNUdaXa8CnCu+VaO4FRXVLxdyZ1UcLXiXQHyx3sxgaEbPUfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
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

--------------CMgbmXU0V2RbyF9xy6hb0GYe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-02-17 05:01, Christian König wrote:
> It turned that using 4 level page tables on GMC generations which support
> 57bit VAs actually doesn't work at all.
>
> Background is that the GMC actually can't switch between 4 and 5 levels,
> but rather just uses a subset of address space when less than 5 levels are
> selected.
>
> Philip already removed the automatically switch to 4levels, now fix it as
> well should it be enabled by module parameters.
>
> v2: fix AMDGPU_GMC_HOLE_MASK as well, fix off by one issue pointed out
>      by Philip
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
>   3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index e8e8bfa098c3..0e8a52d96573 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -33,9 +33,9 @@
>   #include "amdgpu_ras.h"
>   
>   /* VA hole for 48bit and 57bit addresses */
> -#define AMDGPU_GMC_HOLE_START	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
> +#define AMDGPU_GMC_HOLE_START	(adev->vm_manager.max_level == 4 ?\
>   				0x0100000000000000ULL : 0x0000800000000000ULL)
> -#define AMDGPU_GMC_HOLE_END	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
> +#define AMDGPU_GMC_HOLE_END	(adev->vm_manager.max_level == 4 ?\
>   				0xff00000000000000ULL : 0xffff800000000000ULL)
>   
>   /*
> @@ -45,8 +45,8 @@
>    * This mask is used to remove the upper 16bits of the VA and so come up with
>    * the linear addr value.
>    */
> -#define AMDGPU_GMC_HOLE_MASK	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
> -				0x00ffffffffffffffULL : 0x0000ffffffffffffULL)
> +#define AMDGPU_GMC_HOLE_MASK	(adev->vm_manager.max_level == 4 ?\
> +				0x01ffffffffffffffULL : 0x0000ffffffffffffULL)
>   
>   /*
>    * Ring size as power of two for the log of recent faults.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index dfad7d11826c..c6fd3a091613 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2409,6 +2409,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   	}
>   
>   	adev->vm_manager.max_pfn = (uint64_t)vm_size << 18;
> +	adev->vm_manager.max_level = max_level;
>   
>   	tmp = roundup_pow_of_two(adev->vm_manager.max_pfn);
>   	if (amdgpu_vm_block_size != -1)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 139642eacdd0..806d62ed61ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -456,6 +456,7 @@ struct amdgpu_vm_manager {
>   	bool					concurrent_flush;
>   
>   	uint64_t				max_pfn;
> +	uint32_t				max_level;
>   	uint32_t				num_level;
>   	uint32_t				block_size;
>   	uint32_t				fragment_size;

--------------CMgbmXU0V2RbyF9xy6hb0GYe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-02-17 05:01, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260217100114.2019-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">It turned that using 4 level page tables on GMC generations which support
57bit VAs actually doesn't work at all.

Background is that the GMC actually can't switch between 4 and 5 levels,
but rather just uses a subset of address space when less than 5 levels are
selected.

Philip already removed the automatically switch to 4levels, now fix it as
well should it be enabled by module parameters.

v2: fix AMDGPU_GMC_HOLE_MASK as well, fix off by one issue pointed out
    by Philip

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20260217100114.2019-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e8e8bfa098c3..0e8a52d96573 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -33,9 +33,9 @@
 #include &quot;amdgpu_ras.h&quot;
 
 /* VA hole for 48bit and 57bit addresses */
-#define AMDGPU_GMC_HOLE_START	(adev-&gt;vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+#define AMDGPU_GMC_HOLE_START	(adev-&gt;vm_manager.max_level == 4 ?\
 				0x0100000000000000ULL : 0x0000800000000000ULL)
-#define AMDGPU_GMC_HOLE_END	(adev-&gt;vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+#define AMDGPU_GMC_HOLE_END	(adev-&gt;vm_manager.max_level == 4 ?\
 				0xff00000000000000ULL : 0xffff800000000000ULL)
 
 /*
@@ -45,8 +45,8 @@
  * This mask is used to remove the upper 16bits of the VA and so come up with
  * the linear addr value.
  */
-#define AMDGPU_GMC_HOLE_MASK	(adev-&gt;vm_manager.root_level == AMDGPU_VM_PDB3 ?\
-				0x00ffffffffffffffULL : 0x0000ffffffffffffULL)
+#define AMDGPU_GMC_HOLE_MASK	(adev-&gt;vm_manager.max_level == 4 ?\
+				0x01ffffffffffffffULL : 0x0000ffffffffffffULL)
 
 /*
  * Ring size as power of two for the log of recent faults.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dfad7d11826c..c6fd3a091613 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2409,6 +2409,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 	}
 
 	adev-&gt;vm_manager.max_pfn = (uint64_t)vm_size &lt;&lt; 18;
+	adev-&gt;vm_manager.max_level = max_level;
 
 	tmp = roundup_pow_of_two(adev-&gt;vm_manager.max_pfn);
 	if (amdgpu_vm_block_size != -1)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..806d62ed61ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -456,6 +456,7 @@ struct amdgpu_vm_manager {
 	bool					concurrent_flush;
 
 	uint64_t				max_pfn;
+	uint32_t				max_level;
 	uint32_t				num_level;
 	uint32_t				block_size;
 	uint32_t				fragment_size;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------CMgbmXU0V2RbyF9xy6hb0GYe--
