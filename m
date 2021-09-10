Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86CCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 06:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F00611B0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 06:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74F00611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 153096E96D;
	Fri, 10 Sep 2021 06:15:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA92A6E96D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 06:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX1fk4ow9Rw5JmV8KUmnAM+YMX708/39+c9sFYs4AQ8CSdIH5LOmTvjZJzOqzyFi2ahP7zIDy8SS48Ppx9NPEhOERDtnq61HsokXc6R4ck3KNlsWxSluEO0GMPfRiku2tM+z2xHTcDiF9bwRrTKqj4FrizJRFUlNSSZMJQbe8USCLsHDwvP+1+zd1OlwYeSg7eqdYZUxQveKkS14ooHyExfcQTRY5k/8xmpgJ1JC43hz1NH233dsBnsS83II08wd5T6qnLa29O0W7EHCTcfRPEp94BDXLuzcYABTW4pX6XxV3FEzIG1bdpu7H/gwaMy06ANDADDiDun2oiSL/TCAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/RB0TQxIbX7Zo48ghQ7J30+HD9fBkw3Tn5QDpdu+5pQ=;
 b=ed4tmeeUNJsG60xtPLVMboyM5CQmC6QikOwHF3X2v4toIU7SaN+QZyan2iwZKMmzanwEAoVMB4Ck7I/mC3xIGKyosYV+zbUV7kcrIbitjQzNWPKvch4iXfjUSRJmZTZxOENvkawMdtjJtuH42/f1BOfJ2AT+t5Zf0y+f+da/OnDSoXCrW0Sd3uvCxqXT/qCF5O7iprIipCCmADE7TBImm4RAa1olxeB/37YQohrBEOTKLpWO/1ppXnk7JvEeFKwajJgmM0SMmanin8ml4X9MWFCiYCySgCa7cXiRYs1P+YNyeI5lRIM0Toz5dVNjYpIslLRFL/B5VkV5CLMVORsjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RB0TQxIbX7Zo48ghQ7J30+HD9fBkw3Tn5QDpdu+5pQ=;
 b=A1zGn+b+k4m+gGar0Bi+AHV6GXEb2snap5GxS3Ejo1N1V7VE+Dw6V+/HOw7JuTQA7Sg9WIAlp1MMns067j+scc9l+kwTzD1vSu0tRTssbFchJcnrv6756+qugAwPJnNyjjyRmezM/Sb7macuXCqmBlT4kP0Y35vVX+J00JstRhk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:3f::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 06:15:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.015; Fri, 10 Sep 2021
 06:15:30 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: Increase direct IB pool size
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20210910003828.4013-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <827234e7-50a3-9b87-02a1-bc5156d173bc@amd.com>
Date: Fri, 10 Sep 2021 08:15:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210910003828.4013-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0109.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR06CA0109.eurprd06.prod.outlook.com (2603:10a6:208:ab::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 06:15:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d61b79-1da0-46b1-325d-08d97422638f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB235509FABAC5BEBED8312A4D83D69@BL0PR12MB2355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5nkpDNYnBDj2obBGKzfaBMoIeOiDZ3uknzvtYb3luTThpDGmOO3DtWvYfkjUhTx0pTA38XZHCePnDsT5krOWOYaEt6QryhAwwqq91ruTebXvXJ0LnrXHdpVsoe07vh/WYESmlsa+R9Nwds6XUFF3P8Sq7iDA8PGw2FdLs/cj+mGKDEzqdHieUZZ0JMJqqwbC0LlhHO6TrD1p6yvnBqzvzQ2+ya8Wef9kUoPIghZNEe/VUAbaC+PPwd5iNH/+sJkVQpBcOxiJMphjV7JPP4hx+V2v4OVB3GqyDII+3hjZGu+J78rJyGFcyH+hyuLqFsRHHZjudIk+OcivB6XgEXawtqpXICds1RYBjzoxoqQgbdZYj4wEMmC3XtSx0A7nkYtILPe/iExED4RCD6HoO/F7Tu4bmYYr55f/Ge70jF4E4x8fAOcZuljTnJt/suTyALHPBEq9wdWYxtXpq2pX9tXZYzaRPHmtUJFr3bp+VPC61YaTl7M5gihaaRFkEeNFocb3wfDqcUQAJCRY+NteXyZ2MSrv7SaOtoOy0krpdNc0h67x8BjaOAZoxHEkDWTU9dT7YFtgTN3BOuU1r9L/f1rFPScXlMx/HgLEcqxQLnHG8HKRU+xz0GGz2xm+UTwHxaGoeb8cVP/536qdntJOKJfQ8ql8M7hA0F97vHXjEoDGI6/nfep9snCTuoVXUajLvThZSm2Sj0DuKoXPK6R6DhDt3VMffNZTFA5ZiMejwbmG7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(36756003)(6666004)(38100700002)(26005)(4326008)(6486002)(2616005)(31686004)(66556008)(31696002)(956004)(5660300002)(478600001)(2906002)(8936002)(8676002)(66476007)(83380400001)(186003)(66946007)(316002)(16576012)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nzc5SVlzNXYvWDIxZTg0NXU2UHY4aVRoc0d3NWU1V3hsVFVrLzNDb1k2TzZU?=
 =?utf-8?B?ZWFyRXdybWJpSFFFNytLWFhwd3F6V3RoSjhCOGMvdzVYOFUrUGU3Q3dNVVZo?=
 =?utf-8?B?M0UxSlhIeXdkUlhyY0lRSmRBcGkxRjc1VW5TcTNGN0dncjN3UTR3Nk5iZEgx?=
 =?utf-8?B?OGFNbjZyeHBQbEY4L0sxU2NBQ0FnSDhVTXU2Z2FnRUpIME9SeDRxTnVwSXlQ?=
 =?utf-8?B?UUFmVWhTdGZrYXZMUndWc2pnNm5nYlBsRUx0SmRxdmdQK1FaNXVEVTFsdHJv?=
 =?utf-8?B?cy90eTV4RjZRZ0JwTG9HZUpFTGZyZnQxM3lxZmhGSGFESnkzZ0d5aWNKSS9l?=
 =?utf-8?B?a0ZTRXN2VHJ6a21ORythMHFQdkRrakgzZGc3Qmhhcy9qSGdCSmFrdGhBK1hx?=
 =?utf-8?B?V3BCT1dlMG5aRVRRZ3JDbVpIN0gycXhuUHRyY2JnTFVkaWt2dUd1d1UvVmlL?=
 =?utf-8?B?emJETnNrNG5yZXdIc2NJalN6L3NVMlJCTGhBYTlZdXJLUDVFaXZyQ2ozQkU1?=
 =?utf-8?B?ZUNTZDJuYnlKbmlFb3dtYlFyREMvT2FDMW1Pbm5TOFVITXZvUTRmc1RmTlNI?=
 =?utf-8?B?dzNTckJEVWNJV0lsQzlsLzRSbUY3Ny9JaHZuMzhTUUFRazhvcjJUejhtSVJN?=
 =?utf-8?B?WFhaNFBtVFZVek1RMDZVaUpkdkc1blRwMlZESVhBWjM5SVYwOFMvZTBIakQ4?=
 =?utf-8?B?NVpldmMzeHhqY3pmRTdVYWVIQXB6TnQrYXpEWTFYNXBrUUtIL0FDWEs5bG5B?=
 =?utf-8?B?UUFLYlJNNFBvZk9EaUJwbFVJbmllTXBTNk1YdU4vTm94Q214bkVEWlBQYlor?=
 =?utf-8?B?UEQ3M1cwaDJxeTBjRklZZGdyMXdROEZBWHVhQWFMOHNLb0h6ZVRGZkhyd2Ry?=
 =?utf-8?B?Unhwci9YUW82V0NYZ0EyTzNwZ3lBNStIQmdNT3Z4L0hRZXBtLzZ0T0dWZTYr?=
 =?utf-8?B?ZlJGbWZnRndlSTJ1RlgyKzdhWGZYMUpSTElwWW5tWFR6dTlpcVV2akw5UWhH?=
 =?utf-8?B?VFE1MmVzMmFDcGx0VTk0UUp2clk0ZXl2VjdQWGVqVjkyS1Z4ZGxaZjdGZGl3?=
 =?utf-8?B?eXJoaHR5SXVhNEw4KzdxWFhyY3ppMjlHcVhpTmtrL3A5eVIrTE9oUnJMdGpH?=
 =?utf-8?B?S2hLOGFkZC8vRHFqbUI1Y3RTUjJSSlZDTFp5b1lUL1dSb2pkNU5remxtMmFD?=
 =?utf-8?B?dkdkampQVU4xZ1lIYlVnRm9RbXg5dDUrZGxDNzN3RFcwbWxRQkpYTkE4eDZ6?=
 =?utf-8?B?VnhSVUlIcldGekkyaGh1Qjc4WlA1emdyVlQ0N2VXa3ZHMkdRNEMzSkVacy9v?=
 =?utf-8?B?Ylp1YWZlK0hJdEc3bXJKY0gxRTdUQ0VHUFlsUGZmbTZDTEVtTlVxaHA5TnJZ?=
 =?utf-8?B?bHJCL25qTFZZVGhYdVIwZ2FTYnl2SWxhdzdPWHprTUdPY1Nic20yTCtVV0Zk?=
 =?utf-8?B?dVh4VEhRcHNzUEJ1b29QU3lYRFVwRWptWnZyK3gwSVFBekJDQlVUNVR6MytT?=
 =?utf-8?B?NFRESmprTSt0Z0RMc2RaNkVhLzBKOUdKNGFlb01aVzFQS2N1MVBJeXkyNDhH?=
 =?utf-8?B?cDNrbWZrWHJ0OFRWQ3pMSHhudGJBN1h1TGJOeEFrYllNelRqdTQxNDRia2F0?=
 =?utf-8?B?emtZeU0zNlBpVmFDOGRuek15WVVBM0ljbjZ3dS9rL1JyS3FXOWpURGpjSXNE?=
 =?utf-8?B?NFhSbGd3dktSVmQ5MkhhVndDbWNzQnlMcFlTa0VvMVk4bi9YRUFlRkl0Sm5n?=
 =?utf-8?Q?1dy2KTtg0VLuO+OuwyCHtAnygaby5VrWEh5R01t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d61b79-1da0-46b1-325d-08d97422638f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 06:15:29.9923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAtx8RPiws1Tiu9BaHvGeOFCCX0INLy6NwQmqPkGp3RhpjY/FL+1Y1lCZROdOPqs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
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

Am 10.09.21 um 02:38 schrieb xinhui pan:
> Direct IB pool is used for vce/vcn IB extra msg too. Increase its size
> to AMDGPU_IB_POOL_SIZE.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index c076a6b9a5a2..9274f32c3661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -307,13 +307,9 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
>   		return 0;
>   
>   	for (i = 0; i < AMDGPU_IB_POOL_MAX; i++) {
> -		if (i == AMDGPU_IB_POOL_DIRECT)
> -			size = PAGE_SIZE * 6;
> -		else
> -			size = AMDGPU_IB_POOL_SIZE;
> -
>   		r = amdgpu_sa_bo_manager_init(adev, &adev->ib_pools[i],
> -					      size, AMDGPU_GPU_PAGE_SIZE,
> +					      AMDGPU_IB_POOL_SIZE,
> +					      AMDGPU_GPU_PAGE_SIZE,
>   					      AMDGPU_GEM_DOMAIN_GTT);
>   		if (r)
>   			goto error;

