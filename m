Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A24C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 13:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409DE61269
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 13:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 409DE61269
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46D96EB7C;
	Tue,  5 Oct 2021 13:23:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B406E3FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 13:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTlXIisVxxMO3wNizNucHyrE/KZCDZ/7tEWHSUl6Y5+YzUS4vRXKPUdBaUNqde2HmOU2eanKCnAVkyvHdxW1Y93hJO9G7t0DFphnfk2MTgqu67YBvdQ0F6M1nMHe6bd1Biixnb2tFf7jZ+TRgWFlRidVMQpdnpQ88v0dcbimvtHj6EpGqL/jOG5SfNzb+9Mvh9wkakW+1waAsgV3zV1joPFfl7FGqRXvTZgQ+VEg+qBpc40pIxF6LK2NZwf0YtSLz1Fr/OO0Vnybqfvtk15PeJZEhixFaQswKqs/vHIgwAFpdtOPp2e++HhgJfoUQMTXFiUjIHObCEtieNq1BmdZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT38ueQ/aR2VDowDScUFqOSdc85edGVGVqvReeB68yM=;
 b=XCMLx4VAGb7V5HoZlKoh6Lwr9EFQxNgGoKGiMTqJraoFAxH6J6WFDHEpsFQvUB8HVWuOuIBUiGXBKg4D+TI//UFRydS6mR5pc8BXItCYDJD+bFFTkj59J9OpX5zFt9HAS5iJuiFVLEDcby4MefyJxaEoX2D0rLsCwPtZUksq3TOmBPPGIOwwAjST+lD7TrUJFvQPZUHw6uiXY5N8DoIcaLJhTBZAgsVQ066fyojZdfY9GSYQi2LBIGFwC9uF0p5kY7biHWfI8ctNYfxadHtQsEMhCs3oKHq2G+R8OvG/fyEWwYvmnHfDPIAnc1X+TMN1TFW8GBv9GjPHavOZ4u3iOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT38ueQ/aR2VDowDScUFqOSdc85edGVGVqvReeB68yM=;
 b=2D0gIU7pqfp4Kw1xwjW5XFvJAqvqtEQocOGuICof2mkpX7KMlLZJDcecGN/lQJn7rg7CbHjXQtV7BlkLM5da8p0Z74Sv0UZTWzM5+bIGAqcqvqhSKhJN6vUG1kvCydViblEEvmJz32scWs0W+gn14T/b081hUISNrl9T9jsQnIA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com (2603:10b6:4:5b::9)
 by DM6PR12MB2700.namprd12.prod.outlook.com (2603:10b6:5:4d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 13:23:05 +0000
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::451d:d9f8:29a8:63d3]) by DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::451d:d9f8:29a8:63d3%11]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 13:23:05 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: ignore -EPERM error from debugfs
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: shashank.sharma@amd.com
References: <20211005131115.25595-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ab673b77-e8b7-94a4-76f6-588ad9e472f7@amd.com>
Date: Tue, 5 Oct 2021 15:22:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211005131115.25595-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM9P195CA0024.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::29) To DM5PR1201MB0187.namprd12.prod.outlook.com
 (2603:10b6:4:5b::9)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM9P195CA0024.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.17 via Frontend Transport; Tue, 5 Oct 2021 13:23:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90246efe-85b2-4716-3192-08d9880343af
X-MS-TrafficTypeDiagnostic: DM6PR12MB2700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB270068824263B526A1B545B083AF9@DM6PR12MB2700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwO60cGU9zBr6P/g+NTQ/TnFPCe0CEFnHNP03J+UeBSxnlCFZXaqMnpk9EI2kN862gBOs6569bXKd1BpOeMiaZfUNq/WEo95XlWYiMA74Z0fnpiwCpORXGdLTyEeNX1LA2pLe/nVmcT0tLi+Qt+RxU16xlx2NCLDJ47tj9O13UX37Izj13Vva4Daeh0SMEi6UFSxaGMzt+LPz3zaYvGWLuvtLSzdIMa6Gp8eDQ/2qvC/coRWbsYAjnc1yD1SbExCYyL/4tJjcZOeKqnihjE/fgIgHVA+WtLNNYQLgzU37Gpu/qWatIZWgp22lVxxMu+PQPDNxYf2RDn9uoLArbB867MPn+sRkMi1hSD+7+V0Z44tgzJaBd0r7Q4ZXJ8MuuXd2IGFlOgZLWtYyZaci0aKYPxaj8aRfyF853U2ariTnIgzGwO+k9HlVrf1lRcto4X/R8VGq4mdxRq0ctOWa3ec6OM2upaa3VOqvFQgRQnTnnOxacqsIkDolaYVs9xA0YVqnJ1zxb1KtNCYdxBWukXGWWpjwGMOjhERVH99158R2WbevhQ4c9HdVuzUoqBJkJARiZFsnCAmQE8/57kjVsgWmo82BLFYlx/Zzw38f5B4nlkgvEvDTnqY3VTuZOyi02MRJt8dpux9dzlLnj+zt4TLMpodJjuG7MDAl4lZ5FvFDggDf+svBhviJrL3BuWbkJD5YSJ9C7oEMCNTDXgIwP4uc6OAWtxEnavGQ7cQ8Br9AcF30HMnkPzPihg5GRavtcEn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(83380400001)(66556008)(956004)(8676002)(36756003)(66946007)(66476007)(8936002)(38100700002)(6486002)(31696002)(6666004)(186003)(316002)(16576012)(2906002)(26005)(4326008)(5660300002)(31686004)(508600001)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzdZL2ZGZHJ3NVZXR2pDL05lT3R5LzZaM2JlU05sMUZRVUl2bjV3U28wczVi?=
 =?utf-8?B?MytuT1pLTjlXZ292RXk1czVMcWdkYkpBT2FjemxKWFhTV0IyN002dzBkMGVt?=
 =?utf-8?B?ZUQwN1JOY0szYWNpZjl3YkNnL3MvUnBqcVRXTmZSL2J2TDBhT2tFb2I3KzRJ?=
 =?utf-8?B?dEpYREFFcmtoeGNaM0JXQWMvYnhucWlTVFg1cVptQ3RtMVB0dUEwN3RQbmJs?=
 =?utf-8?B?SEFCei9zUWlOZmdxL0toSmdvWURma20xd2tNMVk2dFRobW1jWXdBZU15M1NN?=
 =?utf-8?B?RzN3UGJieUdrQVNsS0FmWjFHNTRlMXlWWXJOSGZHcmdOVnQwWTVMM201bHl5?=
 =?utf-8?B?bHBmRy9EeWdZeTNnRXg5K1JadWl3eVA0TXJDSnpYVXF3RGQ2UVo5WXdnS3hG?=
 =?utf-8?B?VHhxWFV0cDBuM3l6SERPWDZrcjBqQXlLVzBVSmtvRTJETE9XaTBNM1o2eFpj?=
 =?utf-8?B?SVh5YnYwM2dlQy9QUklGaHQ1a3FMQmUxNGFxN05vVGh4dUxsbW4zMytKWURQ?=
 =?utf-8?B?bXdadWl2MjNrbTNIaVcwbHNMZit3SmNLYkUySDczSWFLMlh4dmppNXBSN0FV?=
 =?utf-8?B?WUdGRFFmc0xTYWp3M3hjK2NBdVNvN0NOa2pWYXdicndNb3FtSXZlZ1R5aHhZ?=
 =?utf-8?B?dkkvZGxidFRoZmh0ZkptS1VlNHBIWDlNa2pTZEwyc1pyaEo2alVuSTVySDE1?=
 =?utf-8?B?R3ZOaXdYTHJkU25weW1zRWw5WE5QdXM3WUJXclZZZ1FFZ1o3MWZScXNDY1ZT?=
 =?utf-8?B?NkZUWmozbUlIRFgrQldudk8xOUs0MExISlIxVmFYaVpGTVlSQ0ZSVk5hZGhD?=
 =?utf-8?B?amlCbStGSEl4aVYzV1ZYWlNWNy83Um5xSW1sSnpXQUtOb052NjJoYTZGTFAw?=
 =?utf-8?B?RmdvRDFRV0gvQ1c2eXIwbG1uN3ZSbWpia01DTlExdGZHTzBiakZGYjNSSCtq?=
 =?utf-8?B?ZHRKcmdQN0d2cWU4T2lzN2xPM2lVNlcwcENoZUlJQytyREZ3MXBOaUpNaG04?=
 =?utf-8?B?ZzRKMnJYL05KUkdJeWp2M3RJQ0dxNGdZWS8wc0JEbXBBckdDWTNjUTVQUUFa?=
 =?utf-8?B?bXlubllSK2gySGtXM080QTgyY3Z1ZmoxNDRmbWhCdkRGc3AxTDhJRkRKaFNT?=
 =?utf-8?B?SyttakpJMVpzNG9UMHFOVHpTbXpyUUp4QU9ZZnRuTGM4bEMyeEVtTHRUY0pu?=
 =?utf-8?B?T2RvSVp0b2FyQmxQZHhkYlhiYWN3VmVHN0plWGFoek5rcWNUbTZ3S1pZOHVM?=
 =?utf-8?B?b0Z5bHI1bkl6NlZoNnZCc0prOXJOcFVyc0pCUEcyTTFRdmhTbHVJTGw2cThu?=
 =?utf-8?B?ZUR5VW5DMDFLVGNHS05uYnFPTVdxcERVeUVsYUtRbWJZaENEVmNNcFZIMmJN?=
 =?utf-8?B?YlJRWVBFRjFmWmVwVkk3R3dJV2J1ZnJmcUU1bndvaUF3V013WURkdVZFdVl3?=
 =?utf-8?B?WkYya004TGNhd1d0S0thcDZpSnl1ckMwc09WdEQxazBVaFpScHFOekVLbXdw?=
 =?utf-8?B?cmg1UDY1bXNWcHJiajY3VFVFeTRmbm5vTlBNb2xPSXB6aHJMeFlXRVNUanJn?=
 =?utf-8?B?ZGM1YU1wT2tPQWg0L2xpRmdzRmgveTJKY1hRMnRGSkJUclVDVkNhRXJOUE1V?=
 =?utf-8?B?ZTRwNHgzaG5HTkQ0eGF0T3VDWElUSVA4dU9wdTdHVUJKUDFnY2tWTzB4dWZs?=
 =?utf-8?B?WUtqVnlIUVJLL2pNVVZpVngvMU1WWUJJSUYvOEZ3cHFEeWUwUk93N2FTMFp2?=
 =?utf-8?Q?uqmAR470+JcI13mqTTZ7v5/tRsLQtH/LJyKZy5W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90246efe-85b2-4716-3192-08d9880343af
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 13:23:05.4548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pnbugP+eLx17y9BwWaSVWqex1ZViPSnE0KPbKkXOGahHNmW5tyXu9c0cxJuw4mx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2700
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



Am 05.10.21 um 15:11 schrieb Nirmoy Das:
> Debugfs core APIs will throw -EPERM when user disables debugfs
> using CONFIG_DEBUG_FS_ALLOW_NONE or with kernel param. We shouldn't
> see that as an error. Also validate drm root dentry before creating
> amdgpu debugfs files.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 6611b3c7c149..d786072e918b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1617,6 +1617,16 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	struct dentry *ent;
>   	int r, i;
>   
> +	if (IS_ERR(root)) {
> +		/* When debugfs is disabled we get -EPERM which is not an
> +		 * error as this is user controllable.
> +		 */

Well setting primary->debugfs_root to an error code is probably not a 
good idea to begin with.

When debugfs is disabled that should most likely be NULL.

Regards,
Christian.

> +		if (PTR_ERR(root) == -EPERM)
> +			return 0;
> +
> +		return PTR_ERR(ent);
> +	}
> +
>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
>   	if (IS_ERR(ent)) {

