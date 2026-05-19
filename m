Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9935CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE5D10E06D;
	Tue, 19 May 2026 13:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J6p2sCYm";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E041410E06D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNA6Hb0eRi8PGfENmilxnmild87zghrX29P+tbU6XBzHaHvRotP6nyYZDLRVFDIa4T3tc2HHqRRIJfVpn+RxtxCbyeDUujcCkqpVErSBM3udbG0+WYFID3oN5KU/PHwRyTdo7ftMnGONpwrPoTzaivFPNm2FORUXkZg9ddRV956NFrdqLZPiu1LNSwvdQKm+/YlfV+zhUuAcwnQd7RJrHa85uA9iAL9VRq594KI0HB5JxJeYrv8rrNVojCZQ00YhIV4IA8KlPAN99wRuZn9RTIz8iYQ28ofThIitOLwD+j4OrazwZ6WLi1Rn57HbeztnJGnY3EhG/eP9udvfJipvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n21oqemx+Qf2OpR/4XyiFlnE/HUx5KqCiZh5v4YrgW4=;
 b=pd7wgTFuSUAcTk7S/rf5GB4fVZK6s57ZzXNVEcNAXacpmP/vAtS7fsKbi/YENV/idlrh38V5Ca2HUvu/wwNpaPt4yZdMn9HBJVJEXLZs28u0JGpY1XsSoCgNSOMFEe8ANcXLPNJp1YQ0g9etSWvi7JQybMW9LOUIiet5eqxr5HDgZbeIBtvF7JM1LjSPLs3AN84huimfTNqKzZ/d2w5KJH9fd4kxgJckPfYk1hJSAk1MZEIqJ7RAuUH5JFlOH/rPtj63HLMSp6puI0t1r9rhWSBdUNQ7nkNDDtO0VrOIGSNvKFd/KA5mJRW+KWwVKCljdqlvUfFyKM+rATbH5gTErA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n21oqemx+Qf2OpR/4XyiFlnE/HUx5KqCiZh5v4YrgW4=;
 b=J6p2sCYmsQw0FkG84oGsX2FOiEUMYqH/b55yzMUgMiSuX5er9E80ifLvALpdGOGs1mw8rZGsZUsdffhknLTwWxrAXpn8xd6uJrDS8vFkybaYWpLbgpL/myekht/7NgxO+LkhpdSrYtg8Ip236oRo1plxecZzdMJWpjAxnXTeI/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::992) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 19 May
 2026 13:54:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 13:54:42 +0000
Message-ID: <97a95842-c940-4689-a5e5-4f9a09062faf@amd.com>
Date: Tue, 19 May 2026 15:54:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] drm/amdgpu/userq: reserve root bo without
 interruption
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
 <20260519111801.1435954-6-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519111801.1435954-6-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: be055d68-6eb8-4d4b-40ff-08deb5ae2d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: bZYGf71SFwmE9/Vi7sh7x1vEEh9gBkBhg45uDNcNne/5HWl2HEYoRkJEHYErVglClLa7elt+7gqI1wKMrZdjYdRZ0iJJ0XKnvOjCw1NtXSc3O7KfRI1aMZ5A817AOKATLUzxH7jNmexY9pHBCeU+xxzXx4WZa2h9VCoBmGyLpdlkmfSAZ0R47Ey0RJWjgfWIxNNzj8J8oLHkgtRaZQPKlPBHgfgVuDlfVTbezkPotqBcRV3DRyXkBAzujUwfaIO9zZWIaIHB+fsne004tQ1yLr6AHT+Y4n293PyIxx27fbs3Gg313oY9vDpncxn5IasudfbQF99t6YUg9O8Sq2Or2K6N05X8KgQwcKCMRZ94F8zO1JsY5enxJISlb01QzTvrl7FwzvBHD6sKPC3T+IijKYsM52ZPcfryHfXJqvrp3A1knXJWXKPYxxr6EFKTSl7sLe2OvQhbkXtQ4lOt0pHfoOkzghxP2x9s7CnWiYJDKkMNGbxmJkKvYi1hMQgCHWGfNbur3bzyTlDUADa3bdIYUTnQz9dM08W9fHAThleTDfUw5OvSyhPvQQVBgu8TdpXSs+4aqhkEcqpTD9c/c8EYhk3sSNiepth6VCfep55c+rOd716wJY3OsM/tiIJ8ozqTTDDEs18cCxavYDQw8Rg/SE6AKtAwnKuVbNfc5GngJ3+EPiKUKDF9TplVeUnT9mkn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFp5RnpvMjUzRVlsdm5qamdzM05TekxjeHp4ZUp5KzhydjRnY0xVbjRzL2VN?=
 =?utf-8?B?K2dkY3QwampGOWt5M0pvNldKTXFGMkxjYTlRbjEvY3Zta01TL1dGeFlrbmNu?=
 =?utf-8?B?b2o1Qjk5NzNPY1E1WXZsU3gzUkRjNWhHckFsa2YvRCt0VnBpWVg3N1hSVk5h?=
 =?utf-8?B?cHpUeHVxWVVUTi9XcFVsWGFTNzZlOTgyZ09QSUJva0NlWVlMYXJ1akM2bVFn?=
 =?utf-8?B?RCs1L3VBVXc1ajREQ1JIdys5UXkrQWtyMFNtbEVWRTMrNDZtcVdVYm8vclZI?=
 =?utf-8?B?NTNEUWRQRkZpMmRkRWNQN2dvNktJS0NqenJZT25hY3BrVnJlTCtQdzRnZ2k1?=
 =?utf-8?B?YlMrQi9oaS9BVFVmUXdTVlRSYlZZS0NUNEsrMFhJTW1Uc0FOektaL05aVFpK?=
 =?utf-8?B?eThXN3hRRE5PQmMvNnJMbGNRZUZwUVhrdHUvd0V0RGhlakNVVURSUFVrTm9z?=
 =?utf-8?B?SFBXbVJIaVcwM1RGNHNxdVo4eFNzcGtsNzhQZkEwejlGWFlkYUZQMW0wa2hW?=
 =?utf-8?B?aHNrZkVQMEhINDNHTXlWdzRIYTdWTXV0TGl0L3pMRytVeGN1SGxxZmxTTnJU?=
 =?utf-8?B?bnQ2Qng5Nm5teEE1K21wVVFBM2FNM2d0eldxSzd1N0p5ZkNrWXJCWkFON2ZZ?=
 =?utf-8?B?MG8vdjJhTlBRZU9tcTJSVWlTejUwS2xxMjZNb003bTFuVFh1K00rQk5oZUJB?=
 =?utf-8?B?NzMvMm1IZmxnck9sVzJkQWwzK3k3NUwxb3ZSVEs4dGJ6R0V3UVk3TW4wRUsw?=
 =?utf-8?B?blJKVHJhWnExdkg5bTV2Uk5MYnpEekZJRjBabDJiSW9ZTjZKRFFvNXZLU0dM?=
 =?utf-8?B?d0p0NEVGQkZzVGh4L29aUFE3L2QvazVFT3ZzOFBQTFlSNC9pRVpMVitROFBz?=
 =?utf-8?B?UnQydDhNUCtkaWF0T2JPOTZpMUxiWlJYcUh1bnF2VWpQT3dnTXZ6eEdVa01m?=
 =?utf-8?B?dEw3enJvakl3WmhRMTd5OGQ1cWc0UXkwM3hTcFNqZ1hQQzhXWmtNWk02TVNH?=
 =?utf-8?B?dE0rZ092MVpKT2xtQVhDUjlXdjVqWmxpR2lJTGo4aXZySVd0V3dIanZHZjRk?=
 =?utf-8?B?OWh6dXkzZDBaeGdSYUEzZnpDck84VDQvY3lUaVQraXRKRm8xaTVsV3kxbldX?=
 =?utf-8?B?TzhzVW5JTlhYbHM5Ykl1T1psY1A1dGx3SmlqSldKS29SKzl0TUFHUWlFd3Ru?=
 =?utf-8?B?V0ttQVVncENvVXpyL2NaNnpjekJBRnJuTzV0UWlrZTRBUDkzQlB5NlJvQ3pa?=
 =?utf-8?B?R1Y2T2xKYmdGajRCaVNNejFibjl4T1E4d3BKc29va2pDM1JkSmwwKzduN1pz?=
 =?utf-8?B?NFdydVY0TVlIem5yVWRtaWFiWm9KSmxoMHFOaGoxSS9HeElDa2hZQ0NEZER5?=
 =?utf-8?B?UWRyeUdsV1JsOTRMMmtNRUF5M1liQU9kVTFtY2t5MjVFQ0JjM0tnYWRKZ2pJ?=
 =?utf-8?B?ZnpjVmJPMTkvQ2tjYk9oMW9McmF1TWdkMmpoc0p4NHVKSjlqVkJmRW5rQ2VF?=
 =?utf-8?B?SCtUYlJkVTdJSk1BbUJKbUZad3dpRlFPem8zWVQ3dGVMSzVXdU1jRUVoMXI5?=
 =?utf-8?B?L3drRi9oQzNhZGRveDB3dmNzNUl5N0VCRXRhVS9Jbk9zc05XWThLd00razVw?=
 =?utf-8?B?SVhtY2plaC83SE42TUI5d3R2ekdNUlpXbkExZXBDeUk3VjBFbmI1UG9PN1o2?=
 =?utf-8?B?RU00KzNWKyttU3duUGJsaXdPcnVGSTdFVDFSWW9aUFRUUnhGRE45K2dpRStt?=
 =?utf-8?B?UlRwckRWUjVFK2xkUFNSUEZ0ajdrUUZPcXFnanpUZlR2K3Iyd3lxQWlaaEl4?=
 =?utf-8?B?MDlCbUJRc3JIWk84UEt6QVdYVzRtbWlXQXJkWXVkQXo5UjkvSkJGS0FoOUhE?=
 =?utf-8?B?UTBnTkd2YlB1Wjd0RWI5K1BVMVljUXl0MDhJcDZEdUZOOGZwell2Qzc5NHoy?=
 =?utf-8?B?Z2s4T3dmYXByNHpINHRNcHd4ZHpOL0IrR0ppRitzWGNNbjhwN0pSM2VCc29z?=
 =?utf-8?B?M21WRWorOVIybmthZk1RVklDeXdBeW9IK3lyL2hHODM4SWdvSHZMcWxoNmhT?=
 =?utf-8?B?aEhtQmliemJ1SmdEZ1RVVVhNbVA1dmEvMm43S1o4elh6OHA4UFBUWWg4b2RR?=
 =?utf-8?B?ZGM0cVpxWnRSRzArVnllenFnNll3dkFic3BnQnpNeGlwc0VoMjhWL00xWTdl?=
 =?utf-8?B?VWwxNEU4Q3U3bHRxWTZyYjRSQmJzaFl6bFc5LzVQNS9oNmk3aWhUUmFPTnJX?=
 =?utf-8?B?RDNxcVpFUVlkdCt3amlnZlNhczZqK1JiSzlnVUVhMXNqbWFXWnNPUVhkaWlD?=
 =?utf-8?Q?O+QbETyn9wxr/qY+6p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be055d68-6eb8-4d4b-40ff-08deb5ae2d0f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:54:42.0888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVHsFlnR89Gk5LJdW24fQSOSWj4zasr73CGo2v/V8/CDI1SGXfnyZMVHX1X1l3aj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9
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

On 5/19/26 13:17, Sunil Khatri wrote:
> Fix the code to make it an uninterruptible reservation
> for root bo.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 47a38fefad89..c8f7bb23e2c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -620,11 +620,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	/* Cancel any pending hang detection work and cleanup */
>  	cancel_delayed_work_sync(&queue->hang_detect_work);
>  
> -	r = amdgpu_bo_reserve(vm->root.bo, false);
> -	if (r) {
> -		drm_file_err(uq_mgr->file, "Failed to reserve root bo during userqueue destroy\n");
> -		return r;
> -	}
> +	amdgpu_bo_reserve(vm->root.bo, true);
>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	amdgpu_bo_unreserve(vm->root.bo);
>  

