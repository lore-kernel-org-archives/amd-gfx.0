Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845C5CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 06:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8D010E5AF;
	Tue,  2 Sep 2025 06:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CDV2FR6P";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F68410E5CA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 06:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFurjQWDUsSRjOcTeIEArSvRowjpDhU2cPwD+/DEov2Zud/VXONXwwzFfoReRNGyJg0qoeAanvIUF7bOgt/EIvXiPeIeXXK7ty9Cm5tD9vRXSohFdkqYQhKW9RfgJRy1bhFiXwPGgpoDY9/1GOuwzoE0lgH5QEnELH87gHE375uxt8oDeuGPjFBTKd4vGQGYZ4Ow/bZ4zRcur/bIYiKioqZBTiOLVOhH+HPFnpK3wr/ehL91zBXeLpTy9J4kU/wzS0JMXRQzJ9htxVmovBCJRcCpe411+6RJdkUNkue86ai666jit3Ak1LXfvTFi6oh9PtDgaSc8h05sluWlur7uTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAPiCFqS6Uf8G9JJ6719KjOQ0O3qFZGYHTadgr2XkJU=;
 b=aK9VutFI7zG03eEbGJXhWlaa+MVBei+RcjSH8/oPAy7MzgT0soyjYjN0ktcVtJjZYoGIhVnnActMS4Bo3hpoBE+MqGTOUW7Rq/L0tuqAt3+AMH8mZAczsSOP1ztXwtD4bXkpH2exnj+PZkmAq+bVRSTCNeMHDsv0ZEN6jkFi732QbTwK1V+eh/s+5uybgMcHetDA8/CxIuojnJG65FbQZ2YUI4HdhgT2iQD83gLvLuvzOl5l50m2g5ORtBM7UJAoEYoBteP2hm+rpnFaA6f60hveoFS4/2PSgoBASqlVLxU+Pv2dUP5Au9bQpOLMSR7+xFxPjQnWptzC/i1RbNWI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAPiCFqS6Uf8G9JJ6719KjOQ0O3qFZGYHTadgr2XkJU=;
 b=CDV2FR6PEBgv9AlThNU//LR2g7CQ4dgh4hwFCibbMBYy3IH/NltISXEq9PCMbzsm4FfdAqzlZ1SEEfknpTwN+50AQHfNSIjuiZ+lQXQEmPKnRDMxqNN57mQclnPDRxsGJ3np1dtUjLd5M8qFL+S+2aFngbNfpiSKI1oeUj8Fxd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 06:39:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 06:39:12 +0000
Message-ID: <64c1bcdb-8954-43a6-b0cd-90c75b29d3f4@amd.com>
Date: Tue, 2 Sep 2025 08:39:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Fill extra dwords with NOPs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250901100012.439155-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c2998d-5f4a-4649-5b7d-08dde9eb6d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3VoSkc2c1VGSFRjYjZ4TWNtQnhPa0s0QTZIcjhFWlNwYTB2M3lITHd2Vk11?=
 =?utf-8?B?RUVPTXowZ0VLMXJQNGtaZDcwNG9IZlhMZlhkNXNDMXJIZ04xNFQzLzlleFlV?=
 =?utf-8?B?TlpFUjBiZi91ZWtlWjlqMHp0SktVck44UHh3QjFRWDU1MkdTRUhaSnIzN3hw?=
 =?utf-8?B?eDJRTUJuM3ZqL1oxNmtmeFRSOHVuOFEwdjhwd01EM3BuMUl2ZkpvSUhJU1Js?=
 =?utf-8?B?SkgvNXdCeE5jTlp5RzBzWGgwN0dCVDVqQXNTK3FMR0VQQUR6NWgzUnlsbXY3?=
 =?utf-8?B?WFYvSWZyVXZYbHg0V0hOaTBpM29jTUFraWVxZGRVcG9pdUxvYk5SdWZKT2JN?=
 =?utf-8?B?Rk1GbGxMUWFSRHdweW9ZTHVTSVY5QS91OER6amlLT2JIU0twNWNLSzlPd3pW?=
 =?utf-8?B?UWIza0NsWGNIY3ZTQUtYNUVLdEwzN2lseHpWQnlhSDV2dEJveU1QQ2hWTFlu?=
 =?utf-8?B?WUhIdjl3UVpBWXNwV0NwL3hsOE5FL1NKYSt5dHNMQ0ExVC9JQU5RUDFDOG1z?=
 =?utf-8?B?cUlwTmgwSHhPWlRWTTN5Z0N5MkVTQVFmTHhlVVB0Wmx1alVGR2FSTmVFY0l6?=
 =?utf-8?B?cFJxU3A1SHBhRExUUWZlbGlDSzRUaG9rQmR2TnE5VUJlcjM4RjJELzhSYnpS?=
 =?utf-8?B?SURjZk5NTVlQREtGUGZKSFEvZnB0VUIyMjF5MWhjbUJ3aG81RmZFUUFiei9o?=
 =?utf-8?B?S1BqaVg4VjVlbDlvTVFXN2JXbSttTlVrb0pIV1NSL1BmWFB0OTVhWUkwUHRI?=
 =?utf-8?B?MDZ5aGxPZEdaL2w1OWt6dzYxN0dQa0duV3hYOGFMYlNFYThJS1JRZ0FER2ZO?=
 =?utf-8?B?NkhZZXVHczM5RWorQnZWRmhxN3BCbWlVbXpkVTU1UzJjakRFT1BodUNld0s0?=
 =?utf-8?B?ejdhQUFTK1p2U1dJbEZkaWpqRk4rN00vTzBXc1lzdUlrTGhaYk5hV2pUN3BP?=
 =?utf-8?B?Wno0UjZrR3g3ZllEUHQ5dmFkUTBuemptWmNlYkU4NUNhK213ZU9JNjg0M3Bv?=
 =?utf-8?B?enNBRzVhWGJwMjhLcUt6ZUY3ZmlqdUZScTZ0TUlqQkU0UTVxbk50UVhSclpB?=
 =?utf-8?B?WmlPYjdkUDVMeUxoWEk3MzdZQ3RKMHhWTDVKYnlCY29NQ0xlV3ZIcG0ySGRV?=
 =?utf-8?B?bkVRREcrZDJqckVPQ215L2xWQ2ZFYllKR2RUVEYvaFNNTUI5Qk1lMWRvOTJP?=
 =?utf-8?B?SDBUUjU0OWtTTFdwSnJmS2V1dDZXQVBwOTdWajFzSFpNb2FtbkREOUsyTG52?=
 =?utf-8?B?WVFoZTB3VkNybUQ1WDZsM3Y4THVKaXI1dTdIRHdKQVpIVzRmVCtNMUUvL0Iz?=
 =?utf-8?B?SXhDNzVoY1dBcGZvU3hNSFJPRzc3cENCM2RZMHhETlJ3OWJKeVhpalBJbGRr?=
 =?utf-8?B?UlU5Vmg4WXFiaW1vQTRKMFNwUVVxbHl4WHhSSmZRRTlEQXpjU2pqVFpFc0JR?=
 =?utf-8?B?YmtURnhoSjN4ZTdTVitzYXdJbzlNNUM4RDA3d1FsYytud1Z2dWZmVVZ6Nzls?=
 =?utf-8?B?SUhLbUhvU0FET3FvSjZqZVFueGZyQnJqWW0zQ3Y4TWl6OUY5SXg2b3N4VEtV?=
 =?utf-8?B?SWRQZGxlZXByVjlUR2lFR3B4RExwWWdVaHhaRUlrSVNhdk1Ja21DdDBKMVd6?=
 =?utf-8?B?bytmTjFVdVlDNzZpSEFWQUpFZER6NVJxQ1BOWEpRL2JmNVZBemtJbW9pOVJ2?=
 =?utf-8?B?ZU91VWs2elpEQjlWRi9icXVJNHpNS1dSaXJEaFIyMVdlcTlOOHo5OVFGeEE2?=
 =?utf-8?B?a25jazlHamRnWi8vQVdyUzQrbVVnWFZFZllRMU9tRnF6eHNZOHVJbHkwc29Y?=
 =?utf-8?B?R0ZyOStZbVV3ZUpKMlJnQlBGbzg2VWtRU2lqYkthc3pwUmduck1ROGZuK09C?=
 =?utf-8?B?RGZwVmkvaS83WDc3WXZqSWlLWHljenV3eU9LTjZ4czlTVnVhNFBqMTZRQ1BP?=
 =?utf-8?Q?VUkXqvn2Jqk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpqUGhEb1UyQ25NaTl5QnFDQWRpUXNJQlN3UXdzWG1JMGVRRVhySUtvbmRK?=
 =?utf-8?B?UUhScGx0eWRRcXBkY1FFVnFzUkpIaWM4d2R5NURWZWJWRCtseUY2dTIvTXVJ?=
 =?utf-8?B?NFUvSkY0WnhsOUkxeHhSYXRZZ2FsUmRqZ242M3lVdnBFcUdYbGVvUlhyaXhw?=
 =?utf-8?B?N2M5Uk9OSkQvZDNFNU5pcXRrVFZpeHhwV211Q09sRGpBZWIzanBpYThFejVn?=
 =?utf-8?B?VFA3NkRjOGpndmtxa2dhY3pCZzdFS0RnMG9BbW5uNzdEZE03bHROYU51VnFE?=
 =?utf-8?B?Y3FDKzFhR2wvNDh4cm9kN2MvZEtGS0Q1QkF5cm95WkNiOXgwNEtud1BtQy8w?=
 =?utf-8?B?dWRyWDNZVkE0S3BUWi9Zbk11UThCOVI1N014VWFpOGx5cEwveXpDYTB4Mi9U?=
 =?utf-8?B?K0hxUUJ4dVB5aDJZSkoxYVRGdkcxYW1Wc2h4NHJxY2FYaWhDaWRiTUNsNWcv?=
 =?utf-8?B?VkEvYWxpdkZ5SHZRZHhVODJEa3JabmZyd01xdmhTVHovL2ZUOHZXWXNqQnRC?=
 =?utf-8?B?WU9UdUg5WmdNTEhSQXhKRldmOU9hSllkNmIwaXdxaHFkSnNRV216U0wrMGZz?=
 =?utf-8?B?Tk9tSm1LUUE3aHlqMEJ6U2llaE0zaEpIeTNMTTVvVHhtekdCdUVjOG4xNWNv?=
 =?utf-8?B?QnJiekZnUEVydGV3Z3QzQ3NSWjczdzFGalBmNzNic2FkMTBJS2VDOWtMa21U?=
 =?utf-8?B?bXlXNXoxdTVZdGJheFBRTlVuUmZrTlNPc2wwR2M2ZlVSODdHZUZxY056ZCtt?=
 =?utf-8?B?TzJmeTg2MzNTSHlXakhFWTBZSlI0bVcyVllHVmZGTHRUR2drM3RMZ3JOV2N0?=
 =?utf-8?B?VGNlenZtZkVuSzM2TkZtUVlkZmVVUWF1YkRlMGswVkU0WDIwZ0Z2Y1ByVUww?=
 =?utf-8?B?WjcwUzRoTmFKbUpqMjdWeFo5QUQ1YTI0TXBxWFRCaEcrSHJQZmxreCt6VTN4?=
 =?utf-8?B?bkE0S2FTRVJMTFJxMm1ZbXlQN200Tnl6TDhocXJwK3p6dGM5Z2ltUUtXRUhy?=
 =?utf-8?B?d01YbS9iR0RNS2ExbFJNK1pEQjU0WlppWHM3WnJHbFhVdVRLbVFleGM1TVcx?=
 =?utf-8?B?TzZQWlBmNEJ0c2RlMHBRQ3JOZE9qcWFkNm5HYmEwci9jNG1vc25ET2w2b2tt?=
 =?utf-8?B?Q2ZZSlNRM1RBK2tGNU1HdXltcDVXd3VJR3JaNFVLanNzMXpsS3pwVDdrWElo?=
 =?utf-8?B?MC9VOSs0RHNBUllqV05JRnJoZ0xXOGpDcHRPaFcrdnpvVkpodENHbEVUVXQ5?=
 =?utf-8?B?NEZTd09EQ3lCRW1CYUFjOEpXb1FuR3Fjajc4UEhRSFhGSkh2N2pncytuUWFk?=
 =?utf-8?B?RXNHQXFCbHBONDFoenhKY2ZsdmJuamE4NzFoZ1pMaWxBK2RjMm1BaTVXU2cw?=
 =?utf-8?B?MTZIMzZwNWw1RGloenVRZkNxbE1kakduMksvRG5kUTk2RzFCcmlWNmZCNkhX?=
 =?utf-8?B?aU1Uc3BKWmlCb0hsbk1ia2xxRVpoZlFsMk16TGhPR2h2RmY0a054L0RGZGVJ?=
 =?utf-8?B?TVVaclhrNTNpMDU5NitqcnNhRm5NR2drUWo5WUJpcm1YK2lnaWZkMlQ0Rk03?=
 =?utf-8?B?anZ2MjBPTU8xaHh2SWpIMDcrYitBek9EZSthVmNXbGVVS3JuTDBBSlBHRnFP?=
 =?utf-8?B?Rk5tSWhpUk5wSVlHaWt4Nmh0V2JpNlVQb3c0Y0l2MHoveWNlemNPeERmdUd2?=
 =?utf-8?B?ak9iVEVLb0t6aHd3Wk5TVHIzU2lZT1p4SWNJQWhReW1mM0g3cVZKUGVoWjZ3?=
 =?utf-8?B?NG5vSHJkSit4WjV2R3V2Q3BtRGxLS0lWcnNPay9aUzhkaWg1TmdxWXpTd2Zq?=
 =?utf-8?B?RyttOVl3N2oyMndod3MxSzFOaURvZncrQ0FCdUozYnI4eWgyc25jeDM3eVps?=
 =?utf-8?B?M2xydTloWHQ3UGdTSzV2MFhTSWRrSXVDRkJ5SkZJc05Za2J3OXozcTZZSi9B?=
 =?utf-8?B?TGQ3T1l2cXhCZWNlUXd4VXBlL1pHL0xkY0ZQYiswbkN5RUhod0tkNmd5aFlS?=
 =?utf-8?B?UHN3R2ZaZjRLb3RJZEY1eDFxYTY2UGptMEdqYTFlUDBBMU95R3RvOUtteklH?=
 =?utf-8?B?L1pWRGVLQkZOZUNheVdXOTlEdHpJaWM4SXBuQ3AzODJOK1dRYm91UDNyb2Fi?=
 =?utf-8?Q?0sbY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c2998d-5f4a-4649-5b7d-08dde9eb6d8c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:39:12.4002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10XEHW3h0yLdZ5XOxsovUPNvhIWMYrz2D5Q9PY6LizSkuQN4CkdJ+haEar5euZio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

On 01.09.25 12:00, Timur Kristóf wrote:
> Technically not necessary, but clear the extra dwords too,
> so that the command processors don't read uninitialized memory.

That is most likely a really bad idea.

The extra DWs are filled with a specific pattern for a HW workaround.

Clearing them to NOPs makes no sense at all and potentially even breaks the HW workaround.

Regards,
Christian.

> 
> Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for jpeg ring")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e..6a55a85744a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -474,6 +474,11 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>  	while (i <= ring->buf_mask)
>  		ring->ring[i++] = ring->funcs->nop;
>  
> +	/* Technically not necessary, but clear the extra dwords too,
> +	 * so that the command processors don't read uninitialized memory.
> +	 */
> +	for (i = 0; i < ring->funcs->extra_dw; i++)
> +		ring->ring[ring->ring_size / 4 + i] = ring->funcs->nop;
>  }
>  
>  static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)

