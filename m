Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90130C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 07:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493BF61BC1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 07:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 493BF61BC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49136EDCF;
	Tue, 16 Nov 2021 07:49:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D81A6EDCF
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 07:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGwVdA9ygsF99XnjUAHK9YDZMSeFFGvXHzn/lEffRbCThchQ37aPjh8tlLy015v33PcEWh7TnCGG5/VqC8jTYmSCHDVR8U0Rp9sxFeL2p1ol3F/Pu4psEEswEq6h+srrRqvoqyKqpSNyOcol1OihQf6FjnIxUpJ7QqZ84uaFO76dpTCxQBewZi3e5pQdwCYxVGM8z8hUXLEI89t7DBo5XWHJqShi0k2K40+D4quT9RdO7fXUTYuapia9uQrwNK66kOY/RhV7CXHhu8nIf9dg0L67om0IzIAcG+ztXc39ZPvv7Mu07iuANMXrq2THFX/CtqHFBVVnS0ww99FyizBF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn5HhcHufNDi6u17TPRFqLGulR4Vm/e6C2dxDh0wiuU=;
 b=c5D+m8niKXwWpijoluOee2QW9OHQTHkPOdAb60xJKPVtDMx9FBgVE1kBh8VCvQgNt/BHAF3ElufMLcwXAdSd+B0u7VIdwvXfBBQByNDGb8ai8PMceclFKJVZulVkeIEb+Q2R1pn3XVYo1BDuUHNMuKO8t2f+9XUDAwn+sDCQe/bxTJ5fHyULWQgIKzyKtSfll6CwFiIayGA4OcYvjMLqJwCMgUsHiK2iCxzwijFw7Tqr5HYLk4H7mTWMw6PdBOiV4DO5v84Pbs/PWT9da1a3qMVNNrm2KHCQa95e3NBdKaAc2fHxDcYelEkwaF0LqqvPA0942e0/6VU1ICUC7t1/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn5HhcHufNDi6u17TPRFqLGulR4Vm/e6C2dxDh0wiuU=;
 b=Mh8I3vM28AqSWhlodpATGVFwJ6XJgtW1e/vim83rS4qsxir/7VLRb+bs1GER8jfAfNtkieL0ElwViuL5z5rJ4ZfS6o8aYm959vri2JUTsyj0K3Hnh0hs4u4L121j0VErZOcuOf6asehU1XRbh7ZKdPJ96pOHn+cKDCxSJouhdcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 07:49:30 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 07:49:30 +0000
Message-ID: <5666e05e-5d90-fc4c-7279-691115046deb@amd.com>
Date: Tue, 16 Nov 2021 13:19:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH Review 1/1] drm/amdgpu: fix smu not match warning
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, John.Clements@amd.com, Tao.Zhou1@amd.com,
 Evan.Quan@amd.com
References: <20211116074342.31651-1-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211116074342.31651-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.25 via Frontend Transport; Tue, 16 Nov 2021 07:49:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bc10025-120b-46e9-8490-08d9a8d59f27
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4338D5DE6E119952F321546C97999@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DzFApKT6cN9zQTKrIVCqmJ0Hek0bWseltAa+8yunYi8WJAak3+F3R6cqpmWrHO2sv1rWwyIBYAuHyWrWacOOEGm3xupknmlIKi6KF8OPbN/cNUj+dfeUfMwKkLkhXHJFcHAiE0vsKsizT7HMMRurPkiIvUBLvAjgASG5WTOZCQQLRsFUdJvylwZYA1A9tBkS7yzKpL4wA+/GBpceZFzLkTT+TCOLW9sIc0oSgA6pwuh/iDwyD4Czlf64bEsanSTTXZ3qVQ9PzWH4EeexAXcCzySWVTwjoH7cm0LRCSQsYrJZCJmpR4w0IEZ5yObXMtOzhz3DrSWk+0eW3DjxwlgvHTKWMDVFdy8yHqJZEn+18mQms0xHJANPoy9r0Ek6ap202Yejkvimdxj5aAa/ENiQ612WGhEDZ4ZnD+OkfnHD7PbwunaSIYj0NSi4QQ+UZKHQQQdwsfTLZmze29675BdLMp3IQqIO2IbqCeOc9Rr6H3Nma3rL4ocB612US0/qmpWbna5ZM9z6SlWsA1/lqvzNn4D1/Kw7Sn+JvXV3OleGN1v4fj/P7tXgDAfL6WuHNp4q+wmlP/tuf2qmsejPymimd+MGRb6LRhRzNcY0wIzEP+zaSzKxvgCQMiGxdI5GE+TkK/xJ6OqGOyqrDNLRm5sXH0cwJTZ9MAPs9c5srxVF87w5AaEM1kZ2b1D6LoWEXCIWLVjArBBecsvp4S3W/TmiGLvhSLqg57krGts8cyyBRyLRX+hHYjkKq00cIDd2wwd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(31686004)(53546011)(316002)(186003)(38100700002)(5660300002)(26005)(508600001)(66476007)(66556008)(6666004)(16576012)(8676002)(6486002)(6636002)(8936002)(4744005)(36756003)(83380400001)(31696002)(86362001)(2616005)(956004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3drMjM0TkFNeDczV1Ewdk0yS2RGc20yQXY2b1U2aFM5a0EzeG1HRGk2eUkw?=
 =?utf-8?B?UmV3NDFIL20wTVJCNy9hckpKMEVzR3J2YXpjWDRLSUFnV3JEdXo1a2xncTdo?=
 =?utf-8?B?bS9BczNkRW1rbDFHWlI5VFBSc3A4Z21HQ3cvNHk3c3VuVnFpZUtRK2h6VDVx?=
 =?utf-8?B?RjBYQ29FMHhvR1dzYzByMFBRRkx3R3o3cDJpckhHekV2WXVPQnVxbFZ3NGl1?=
 =?utf-8?B?Zy83Z2pFbGdINzlyY2psRnNURlFTNFQvb012ektheDRKS0MvQ2xrYkZMTE1n?=
 =?utf-8?B?MzRHM0t1Tjd1WGRxV0lyenY1STRvbDMxeEhiNDNlbTNsbGpJQitEeEJWUW9K?=
 =?utf-8?B?WnltOGxFYW5DOEhOc0h4QUo5aVJNSjM5WFRqME5CUXMyS3JTamdBWHMzWm9m?=
 =?utf-8?B?QWR3QWNxcFFEMm9VV0lzRlQxUXlPb0VCR3B5Ni80WmorT1ErN0FWRHMvaFVy?=
 =?utf-8?B?K0hYUGQ5SDRiWHYxV0Q5VVhUaU1Tam53ZVpCTGRwdXF3Vm9aSXErQ002UDQ3?=
 =?utf-8?B?NG9wNldua1BWOVZuVlgyazREKzlvZWZ2cFhYQlc2WEtuenBCaDRycWZpeTR5?=
 =?utf-8?B?VXVldFJ5azJwZitVbE1zd3FBcGgrV01tRXdFU3RTckp2bjZHOEpOMyswOHFE?=
 =?utf-8?B?aXdya3BjRjBFOVZqMXlsMDhMenJsa2V1MVlLRTlIVGdmbXl3V0pSRzZKMkVX?=
 =?utf-8?B?NHh3OFNpZExRZGd2SUxvOFowbTdtRC8xUUcwVkptVjh4YWhMTUJlMVNQVFdQ?=
 =?utf-8?B?MHUxWTF2SmgweDRyNkVBajh6MDZ0WWdGVDF5bkNkUkpFdDZ1ZmNjRWdjbEUw?=
 =?utf-8?B?TGZ6L0tTaHkzTkF5aWVIKzUwWU5NQlBGbEtYWlljN2dHNDJoMGhsR0R5ckU0?=
 =?utf-8?B?MldCdlRPaTNMZk4xdzF6TWU4QWVjRVhxaDR3Wm05R2lNeGxhM3lJTi9RZ3Jw?=
 =?utf-8?B?ci9pZG9MbE5DcERTNjRkdURoVU1IY29JcWUzV24zZ2FJVUlNckVaOWk4UmJI?=
 =?utf-8?B?dy9DZzE1c3NRMkFZYzFqajlKUG80U2lBQU5Na2Y5V0JXa2pOVzJ2MGRTT3Vy?=
 =?utf-8?B?N3F1Zy9OM1pKVXlTQTc5RTRteGVVbGY4OTNYZWQ4RmtJQ1dOMzR5czBOWVNI?=
 =?utf-8?B?bDlESWxZV09PM3NzOVF6TS9XSUhZeFBYODZSSXVQMC9pT21BbjdYUjZVZE4y?=
 =?utf-8?B?WE5DajV1YS81N0tEdUUyYWExNUw4d3hBdXVSR2pBaStwN0xwTUMvZDAwczl3?=
 =?utf-8?B?bkdndk9ab1FqSmg0UEV6TkNxcnU4UDcwRUVTVk9KcXBocHc4bktqd3NhUG9B?=
 =?utf-8?B?WnpvdC9lK1lJemNJeW5VaG1EY3NFVG5hNVBURENKdG9wV0I0VldXL21RRUZa?=
 =?utf-8?B?ZXNxWEhud2JBdUVCcXJiRGIxQ1NGWkM3TlhCNjdDbVE1UU9oM3FMU0xJb2Z4?=
 =?utf-8?B?YmhDM2E1ZG5US0M5WjZUWUEzK09RdUpaYXllT0NhZXRHZFdxeUtCNHV3NGNM?=
 =?utf-8?B?RE5jSkhJN3FYenhwVE8xbzAyMXlpVEY3eUx6ZXlHdHpoL0Z5NFNrelRvVHpR?=
 =?utf-8?B?UUNOS3VySlp0VWhxRmY3NUJsdzE5aytQWVJob1hMSC8xZEF2WEZVekQwQkl2?=
 =?utf-8?B?N21OYWU5ZXkrbkxPMkhUWjMrMHloYWdQZG9GWVB1V1lFUStUOHpCL3greU1h?=
 =?utf-8?B?b0dzTVlZU3o0azRXeFhzMlhuYnVYSFNnWG1PU2NCL1JqN3NJSGZyemlXQlJX?=
 =?utf-8?B?UFRMS0xFUlhDV1laRnBCSjJKSDJ3aGFGRTdqakpocVhYcUtzOWNzZFdUbndI?=
 =?utf-8?B?dyswa1NqaHhCSGVMeW9MWG1QZWdCVVhzZGJKOFh1VHZvai94TEdFVmpWM1Fm?=
 =?utf-8?B?TGl6RUZkc1BiR25VaDgyYjZvRW01SzNMQXZ3bFpCTnVSYzE3a1ZHdDNCU2Vw?=
 =?utf-8?B?RlE3UkNrZmRvRGZLckZTaXB2dmJtQVlzRmxtZ2FXQnlhcTlvWjBtWXNCMFZN?=
 =?utf-8?B?d2RTT3IrK0hEMlNaN0loTlFneXhsYmlmSlIzMEJIVmxYUXBKcllXUlVNK25S?=
 =?utf-8?B?OVhnRlNDaDU0Y2RtTUxLa2Vjang3Zm1kVlJhWUZmMElzMXQrUmdKWFVSZS81?=
 =?utf-8?Q?V+4c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc10025-120b-46e9-8490-08d9a8d59f27
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 07:49:30.5261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9JJVfxlyskOHmyuesGVBTyur5KDvm3tCtD+HUO5IXQrvQRcGym5rXQXOzDRyhj5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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



On 11/16/2021 1:13 PM, Stanley.Yang wrote:
> update smu driver if version to avoid mismatch log
> 
> Change-Id: I97f2bc4ed9a9cba313b744e2ff6812c90b244935
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/smu_v13_0.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> index e5d3b0d1a032..2e35885c7287 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> @@ -27,7 +27,7 @@
>   
>   #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
>   #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
> -#define SMU13_DRIVER_IF_VERSION_ALDE 0x07
> +#define SMU13_DRIVER_IF_VERSION_ALDE 0x08
>

This is not an independent change, it should go along with a change in 
interface file. Please post the changes in smu13_driver_if_aldebaran.h 
along with this as one patch.

Thanks,
Lijo

>   /* MP Apertures */
>   #define MP0_Public			0x03800000
> 
