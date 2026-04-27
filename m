Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE831FF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 11:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922A210E0A3;
	Mon, 27 Apr 2026 11:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JgXr6UAG";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DC710E6CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXQaIaXLYCnc1ns4byDMieaWBKYUP0Q/c+QMI4Tj+9W4IWJMi7iuggNhQTMlkdgM7CyAXbxasWw69DihuN1+1iYX1QSVhG1ZbYFomvGN0pRw877srsWvY2JU/spcFhW0XbjuSc1IpqOL10w352CLn03MhEWouqyqXwi/++ohPxcf1WK2WBuNPz1FwtbAOkaHt+cMUoF+F9blOhprCezbPyi2OcdnIQzKyme3nzQmp2l24eVPQT3wnZR3MnPZGl6hE8mFNT5Pjk6siAW9mpJwHT0cvstYYuxeLak48ZxO+ZltXH1RPLUIVnSJwm8ZyloLxVy23YFvW6P9UYce8xKiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZlGtIm9sK7oDNzEKj2cb7uTqIn5iogI0TgjxnVPcik=;
 b=QtycG999lw1QBXOwb7eHkIg9iz9xIR8RJ9aK+yDZmk7JslSFmBtN4B8VQKEtJMrlHElYWDh/Mi+UdUDyDv1e0usuEMH+B9JnKybxEuoC59WYD6eQlMkqYwTG8eLH+9APClhAzfXJRBapQgL6HkczJZYSzEw7obo5HkngPfwdnMGpm/3b8amSxCD6twhr3gZzKdmO+tNnYeKELe0++6GCjweflhzwaigOzvWwz9rK2BI2fXy3I+rFYu5ITbd1xN4goaz/aYjINa2Rorfv0om/Q7IsHoMwHj2A21X1sun3JWV2XokyMq8BjdJBZXNUIknn0G9zaTG2qWp7Kclyh/Kb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZlGtIm9sK7oDNzEKj2cb7uTqIn5iogI0TgjxnVPcik=;
 b=JgXr6UAG5wz6h1n5glLuDDZrN9yG4l3BkLz/NXV2ZJdCXHVwr1nF4224nJCmpHXptQbs1pYQSkeuxYCc7RQsHxNm5qd+C3rDkrJhxJM3mLKUhSCI9+3C/L98zFauTaFhBfTtJB5BiQoTXwKJVnHWde7AwLanyt/pUs0b/7yMKJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.14; Mon, 27 Apr
 2026 11:19:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 11:19:29 +0000
Message-ID: <3e4d296a-f55d-4a5d-a7a3-92b6893b5e37@amd.com>
Date: Mon, 27 Apr 2026 13:19:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Move
 amdgpu_device_check_iommu_direct_map() earlier
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260420133705.3721315-1-Philip.Yang@amd.com>
 <20260420133705.3721315-2-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420133705.3721315-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0695.namprd03.prod.outlook.com
 (2603:10b6:408:ef::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: c15988cb-bfe8-4308-563b-08dea44ed8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: FGt88TPjB1j1HNdlzPcbrvE8qpNk04NV2j2DBgDV02m6TjNbdxOv9D97S7rCU+nUT7NiNXB3YjHpmU7P/bx9IcGNL8pNe8DLiSqWJvjEBJfRp/xa8QY0Sex1b5Dx99fYbuWHaQkPQTTxlhHVt/dfkUAhBjZVhLQRIyDqkzK/BTFVQudNLZ21NFgZi26BxVo2PNBJ+LQFVBrQMSf7L6VneQgT6Gx9rmAjS6pfh454WAq2aAaiXvB0OWtAsnmdvpwm/NPz0HpGjrpSUVR7MkStdFqxgRF5L4Y715ykvgnckya07BJzyMPG5e3B0UzgaXPAaiK59rBk5JzEcpQQV86wJl3KEjhHzR6WQUMRJwUSfs2JczOd9QUP6wh/mlEQV7CgO+P7Q9ZtVX3vnPEnak34Qe1Vn928picpX5AVzoisG4S4J5uKl1/79yJgBUusbRk1T/lvRn2cvZasUoO6CBPBTI8GBYnqwlAVdzEL1cgdXK+Oz536wOqqBgqCU4vVpsfAhUCELL07ybr/y8B9tCK3z7IRkZRydaw6y7rS1I8Uk8tSJG3Dtsqma658mWYARuT7cPIOX4SLoz6ObCDZ3CWvTyUFJU/Jq+1/Fyga2Bk8+LfbYhDYtuTpQ1Z5b/f/TpTE388FWKLSMTOSXtZBEeSSaF9RZulZdX9q0qJ1pRX5YetT3pF+58PGciVbuMU7hdNHExGegGwwKGrduANLGgOANOAjrYQ5lxQTvOdQEvH8T5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjQ5eEdRbmJXMWVpcDhmUDdzU0JXd1dib1Q5SGhMYVU2U0Z3aFRFMHkzMEJI?=
 =?utf-8?B?OUNZS1UxY1p1Z0FvQnpEWDltc1dQOFFmdC9Pclp2bk9SekRLWjhPdVA5QktF?=
 =?utf-8?B?ZTd0NTNKWXEwS0gzMmRuNWI4L2xRd2N1YUtwRkE3V0pjdUhIQklCTktFdkhn?=
 =?utf-8?B?VzVhQmM3N2VNL2dnb3NzNjc0azJMalB5dm1NZmd3Z0NoZThMNlF4QWQ4Y25n?=
 =?utf-8?B?SzFJRWF0QWYxZFU4Y21UQUNlRmtrbkRWb3BJQW9QUHZtcHQwNzIxdG9TYW5z?=
 =?utf-8?B?dDI1eFQ4SnZtWmpQQnkzcmxZelNJcEpIOEd5ZDRIUmhUaG5Xb2lEUnlId1cz?=
 =?utf-8?B?emZDU1lyb0wzNUtLY2M2RGR2ZkZJb2R2V0R2WHdFRm44M3llUHAxd2JXN29M?=
 =?utf-8?B?Y1pvOTJ4dnRXdnNlMEZjVzFlTmphc2RhNlpGb1lVVUlFalhDc0tVMERFUW5G?=
 =?utf-8?B?OVJyT04xSHBnRjdKalpvdXcyMEl4VVZkWW8vRXF4Wm1ZL0VycjdJTXdVOVpM?=
 =?utf-8?B?Z0VCTVhNZERLVlpYY1hicEZlamJiZmVNbVUwejU5VVdBQ0lmck5Bc3NOamJx?=
 =?utf-8?B?bzZvV3dlY3F4dXdGYTI2RDlDK1JzZkVMd1JNTzAyME5XNjZKY0hnZHBVOTFq?=
 =?utf-8?B?MTNvNG9UWnNTd25kanRBMGdiOHNrWEQxTHNNRlZ3SHpmb3ZlMWNvVnJVdUVE?=
 =?utf-8?B?Z08zcTVWL3NLOTNhTXBjQTR0QnArOStOOUJMbGRPNXpVWVg5YXdYemdxbkVq?=
 =?utf-8?B?cDc0TzhTYjBUU3N1SStiZEhpSlora0FoYkIzTEpsZVhTSURxS2xFOHg5TnBB?=
 =?utf-8?B?QWpYM3U2MWd3a2tKVEJVQml3NHBSUnlwRHN1eXdRdWxla2FKdis2V1ZoQnFs?=
 =?utf-8?B?cWtnQmQ4MG5iU3U0TG94Tlh1MFE2dkJSdThQUHNOVmh5ZC9ZRUhGYTRQSGRC?=
 =?utf-8?B?c213NlZHajBBY2JwLzJKT3BkZGFQVm8rK2h2TUNTZmxOMitsZ0M1M1JCdnc5?=
 =?utf-8?B?RDRyR2ZralBYQzR5SUtFbTNzMzJNME9sdzhmOUQ4em5vcHE0ZmU4T0VtOWtD?=
 =?utf-8?B?VzRRUnlEUk0yYmlFakRZN1VKSG56WUZjTVNUeWd6VzE1SDUyMXFWUEZ3Ukcv?=
 =?utf-8?B?OHVpTXl1MTBuYjNCQStjbEw0T3RmdDIvNjRIN2dmMFIzRW5ubGw5NkFMRmla?=
 =?utf-8?B?ODh6RHNZOXdmSlVhZkUzcWloN3JQQWJyOEpWdXJjdTB0TUhVVVhyQmZGbm92?=
 =?utf-8?B?bnNEWEFBWTA5MmlPZ0VHQmhHZUplNUQrZnlBSXhlSE9Hd3VpZjBVV0Uwejcv?=
 =?utf-8?B?ZUl6RmJBcjNMMkQ5ZUZ5VlV4UjV4cWRhczlDSmpmcUExRWkzejNyYmdXWHVS?=
 =?utf-8?B?QS9yalFDYzE2dTRLaW53ZzA3cFNBbDA3Yk5mUjBrbXVRYjY1ZFpxUkF1cnRO?=
 =?utf-8?B?ZVI1bGl2YWorMmVMUFdVaGluYStGa2xFMENQQ2tQcDVxcVcvUytIRnBoVDB3?=
 =?utf-8?B?NndlZjR4VS9GZTdQNFJUMEc0V3RHRFZWTzRacHFmbzMvZVJPWGdTKzVRaDgz?=
 =?utf-8?B?VldjcXd0VGNHeWIzdGJqR3dKNXpDaTl1ellJMGc5a1BQQjloSC9XUHpmNkJK?=
 =?utf-8?B?OGhyVHl0LzNkSEhKNDR6aFo0dFBRamw1VzU2WFVKelNjbEpSbUxYQzFuYXpt?=
 =?utf-8?B?OFlEOVgvcFJIMUpKSjdtc0h6ODNLKzdaUWpseUt5OEpVbkJOcG9kT1F6ZGxj?=
 =?utf-8?B?QmdTWU9TV292WjNBdk55MXVHcTM4TjFGZE43QTlwVzJQeWtEZHVBdk45M3ZI?=
 =?utf-8?B?ZmZhSmZhUGg5VW1lcUhqS3BIYmkyaStXeFRpYVRsbFEyeHFPL1MxVm5vL1JT?=
 =?utf-8?B?amdzVUxGZTFRWGdWcXdrNW5aSGU0VS9SZjlBUldCbk1iN0FhdlJEdVlPL2Yr?=
 =?utf-8?B?b2tScUMyaGdMR0E3R2FPdDF1UG1mc0xtN2RzeW1VbVEwSDZRK0NnUXZyL3kz?=
 =?utf-8?B?T3pURUNkK0hDOSt4clA5U3hKZURLaFFmQmt3aHk3dy94NTVSNXhrdnNkSWZG?=
 =?utf-8?B?Uk94bXhTQ3VaMWl4MGU4T3BtWW02SE0vWjJzMFFrOXlTdkVubzROZVVvb1pH?=
 =?utf-8?B?d3k0ZGhXWnAwbVd1dGNkUm1KMjExTVJPRjYrZ01qZEt6VGlUVFFRK0N0eFZx?=
 =?utf-8?B?V1RNc2Y5c2dsbFlIQk5KNGxSWUR3cGtDOCtUdnBhMGFDT0k5L0loYXhvRFB3?=
 =?utf-8?B?WXc0N3pLTUdhVyt1Ly9PRERCOXRvQ1h5UEU3KzJJOWZWdFE0ZW1xejkxSXdn?=
 =?utf-8?Q?YrqAA7APxlpq/0nwes?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15988cb-bfe8-4308-563b-08dea44ed8f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:19:29.1771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJ5Pz5HpApl7Ex+/d5uiO6oQ9UNSGGtMpq8b6odd7mD8btmDrCW1uKPzlNU5ooFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
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

On 4/20/26 15:37, Philip Yang wrote:
> So device init ram_is_direct_mapped is available when gmc_funcs are selected
> during IP early init.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bc7e96b58d3f..b139475f65cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3860,6 +3860,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	 * completed before the need for a different level is detected.
>  	 */
>  	amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
> +
> +	amdgpu_device_check_iommu_direct_map(adev);
> +
>  	/* early init functions */
>  	r = amdgpu_device_ip_early_init(adev);
>  	if (r)
> @@ -4117,8 +4120,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	if (px)
>  		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
>  
> -	amdgpu_device_check_iommu_direct_map(adev);
> -
>  	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
>  	r = register_pm_notifier(&adev->pm_nb);
>  	if (r)

