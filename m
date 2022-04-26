Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACA3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 11:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D68C010E05A;
	Tue, 26 Apr 2022 11:18:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320C710E05A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 11:18:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEmDOqhwXLxR3as2rZCPTPuF5VckpER+91z/jUV9BUEK+z0vXXgfNPmRMSbZRDL+Aq0GZQoY3pkJgaf+/Du/V82TGpZfTeLlAKYm4SNMpP7TOntn6j+zuliPAdA1RP2vDAMN8n504Mrne07EXP2zCpBrM3qlvvlZd1YlkALrdr7wEU4n8KCjVHU20KPyq9VtqOEaJF3IfvVRQfPZBUn0a0EOfOCO3fGihKcwwM8DJAnmV1g/6dGYCmDfBnMHQfx+Ffmrbo5clB+/59ze+bwSTFUdaPK0A89F7MlzLBk05RXuXW6RSUt+GtiMc4l8v42XKUypnkwEmDDb99RBHbCBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWS9vHFeb+EZj1aoRuVCYQO/roVvMIW3Cyp1uG1eJHA=;
 b=X57IvyZ2/3GZxdmS7m00RnczDO0/kyMl7PFu070BmzzMBPAWIhzYTa2fO4F8OOsqXchslF9deI6JL03IOEdBIME5OU9ey11wZnB5NTEIUOViwynMY1GjaknviOMSCLru+ArxaHfeglR+MvcpBlZrXeioV9MiXc0w9bRhhaTkexyBDfZTB0jfQWQ+EC+WSbPmjHbkBpgY1czssKu0sqfmPpxj1TQGVpkREoo4AlOX2EB8TBVLl6DPMG0o7XqfltJsoEGmeEwANs6OUFgzLUB7Wp0PSRysRzH+kCXrEMblZu9W76iASXxq7pFrsP+TlLoB/9TxILJBiEh7k1joHo2bKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWS9vHFeb+EZj1aoRuVCYQO/roVvMIW3Cyp1uG1eJHA=;
 b=srXGbKmvz9nhPAMqV8DnIFS9F+vznquWHzutoI/8kPx6udVl5uU0o4oSJt2TROXluWZmB/8OmEykYHBcRy9gApMsHDfGE6qx76D4bHW8CuLH0/gSJI5jZt8lQPnAaV81qxDtOTudSbbAX6E1vb7YOuWE8XD6eVTMqNZXfp1Yc8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4844.namprd12.prod.outlook.com (2603:10b6:5:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 11:18:51 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 11:18:50 +0000
Message-ID: <1603bd63-71f0-87a6-0d18-339bf43568c4@amd.com>
Date: Tue, 26 Apr 2022 16:48:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Content-Language: en-US
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1650869553-28976-1-git-send-email-Prike.Liang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1650869553-28976-1-git-send-email-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c3a537c-b286-4014-7e75-08da277689fe
X-MS-TrafficTypeDiagnostic: DM6PR12MB4844:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB484443A15406A7E6D87904FF97FB9@DM6PR12MB4844.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBP3dFzYXJkbwIHvJE9K7yo1of0ImvoyYbPLO2W9uHDtOBXcvtwb3oq/30JNignQqUMiy8EJwsdKYkZtuLg+AGZ4z8wUogxAO5aLSYkmly1uevdY980v3wT5/IqqmVu+x4Tq/j7baT0S4g0NwA6o9LHEBAJ6EuGwOwmo6ujFUzYLkEBI33ZO+ipU9aRIPm0Uik3G5x2t7UNyw8z/If9ctVxavY2XN+2tlwBckBMxazz1ckwMwAp3aipdhR3HXGfJm4Wou6ft/aJBFrj2Eo7RtrVWMwnX3/k1bdJVeHOEeP3easbYIK4+BIHz35KZMZTd08ee0k8sPRlmZEq1WD+Z+tNW/H5blNycU5S45RfktEiX5JG154c/DtQaBWbWEeXTRwx8YNtNVUXSFM7pGa5a80W7x/Y/BqfMzetdGOEBSDBbavEzyuUpNoWkT2s6ZyIrw1O0zDhQ4wnhhP6jsi7ofDldtIdyKx+GZDzNb5OREXxMhQga0tnsff4TmZX0Iz9/K4YkGXVfvd5M+VXzMChidhLVr998NW52nz4jgJf6N4PtpghKXhGo7G4zLBt8GXztZwx7U7e4R+l0bLtwde9ZO3McvJT9m0Y8AupZr6lzkanu30mr0rXENpzidQn8selYmEhAYj1qag3as4f57aq2Aep4QYaKNzQYjY2oK2OVnUBwwfHZNpf9tJ6c9BcgwWAX42Cp4hniqE3xv1BzC756BOoTs1alCEx2nF21VVUDxcQCiVdXd9DizNVTtxhQLJOC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(31686004)(53546011)(31696002)(186003)(316002)(26005)(6512007)(2906002)(66476007)(5660300002)(6486002)(83380400001)(38100700002)(36756003)(508600001)(8936002)(4326008)(6666004)(66946007)(66556008)(15650500001)(6506007)(8676002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDBSb2xjTjdEWVFBeFRXa3VXYmtlN25yUVRCUzNUWm1LcVlaRk02SkF6UGt5?=
 =?utf-8?B?aEp2Z2wranI1aTBCYWQvaXhyMFpURGEvcjlYT3RRSG9uUUZFbGJYTFhsWWtr?=
 =?utf-8?B?RjJQSERuT1o1anFsa25UTDQwU29SOFZCSVh4ZzZhTDNNMEVsNktVSitvMVFB?=
 =?utf-8?B?MnUwVDlGOVd2WE4wTXN5ZXJOZWljaVNsM3dJTmFobFpGZTd1Zm1HL3djZ3g5?=
 =?utf-8?B?bkF6bnFCZmU1NzdmWUtZNWh2L2M3OEJtUzlQdXFudWZhbnVzeEdyYUQwYW5t?=
 =?utf-8?B?SWI3ZFdNMktkOU5XNDVnME92dldBN3F6S0ZQV0hLM1dLVW1OeTdQYWx2WmNM?=
 =?utf-8?B?ejJqUEVtMlJrWFlEMnhNUTN5VHJZWG5uSGV4c1ZwV2NPVGpXMCt1YUlMVDBk?=
 =?utf-8?B?WWllcVFKbEdsaXI4WFoxK1ZBSmdQQk45RjlGOVNRa3UwT3BMajlGdXQzVThO?=
 =?utf-8?B?SFR4S2FoMld1azlTU0dhc2RkWm1Wc3N2UHIzOCt4K2xOdmFuZUs0NURQSmVQ?=
 =?utf-8?B?ZmpwNUYrRWJvb2V1aW0ybHJMVFFheEFzQ3lheE4wQXg4QVdWNGIxcFp0bits?=
 =?utf-8?B?akRXTnM5WGpFRDZsM2VqZUhMSzZXQ1RCWDhDU3FoTzE2RlJKemhDMWhFVUx5?=
 =?utf-8?B?M1pBRytTVnVEMGNlRnM2OUFEc1Q0U21ORk0rM0xYd21QZXNPZmEveVlkRlpC?=
 =?utf-8?B?MEJ2OGU3aHE2TW1KVXIwZXE1T1NDcVliZE5lNjFiZ1lRcHNlc0xSTy80MC92?=
 =?utf-8?B?azJ2Nk13enFEOW54QWNoT3NmVW9QaEwvcEErM202REFndmYwNkFTOXZreHRR?=
 =?utf-8?B?aHVsM1MrTWVFRnNtbEVYVmI3S0lSZE4xbyt5OTZxNGlWZUJINzZVNnlJNWRu?=
 =?utf-8?B?UytEeXJqUHdveDdYaXBYbFNlSnREeGtxUEtGREFjQnNpSzRpbzE5QzhDa2c4?=
 =?utf-8?B?eGg0VnZUU2NEbk0rN0dhQXNkZVJIcXR4WnRRTWRLOGtjYmRzSkZ5aVpoSlc5?=
 =?utf-8?B?Vk42cWZtQ2ZmRHVXcGhKdmdlajJ2VFhnckxXbXhOTEl3bVBXK01ka2N4Qm5l?=
 =?utf-8?B?azdYTUJTK1Zac2lUM1RINkkyN0hvQXJ2aU5RV2xBei96SXhMbE14WHBldnZW?=
 =?utf-8?B?ZDBwSlJzMWlLdld2d3ZESitPTlVCbkF4RWs2UDE3OEVtL1RsSkljeVJtclNX?=
 =?utf-8?B?bmQycmt3UnIrazUyenFRMmRuQ1VyVldsTmFCdUNvYjliRHVuS0p3MC90VWxN?=
 =?utf-8?B?d3VuTGxoTHZYNU1OYWJZNU55ZWROblE5bWpOY1hQWGxVTllzNUhtR2hQZVFN?=
 =?utf-8?B?WDhFYzh1VzZyZFpiaUVmeE1qVzQyc2xRcytZQ1VudEhiUWQrT1FWZ1paMVV6?=
 =?utf-8?B?UlhlOWNpMEVqaXlrc3czMVdzT0pZeDJZVThpS0t5dXZMQUU4ZWdqaTd6eG5E?=
 =?utf-8?B?M2JYK1dQYzNyV2dVQ0cwak1pb29aYzJaMUhsS1ZNTFVadnZrSE1yRE5zNmNj?=
 =?utf-8?B?MUZDY0Y5bEVGc3ppTTBTVnBzQkZUaTEyMy91RmFIdE9LK3h1dXpiWEJzNVov?=
 =?utf-8?B?YzZrWnR2UGNoRVg2WnpKaEl0V2RzSC84VmVvaGVTbUlHZmoxTkxjSGxaWnE1?=
 =?utf-8?B?MjQyVCt2UkRXVWVTS1VPMjFjZnN1YVpZODBId0VmZ0pNemNpQmdWei8yMERp?=
 =?utf-8?B?eHBzUElGMEE1MUdna3RLNEtvYXcvaDNtajlpSWx2RmFQak1KYjBZbEcrVHU0?=
 =?utf-8?B?RkdSenpMbjN0cWtxckxkZUM2S2RBbGZGVW1NZ0RWN01oQXJlMjNGU2VpdTNu?=
 =?utf-8?B?S2NPZHVYREp6d3VhQnBOOXNxUkRzb1Z4dlJ1Wk5YM2NpdjZFdXVrT0pESEwr?=
 =?utf-8?B?TlA5VU8xS1hiQVR0QVo5REtvNmFyUk9pNElSbHBrUFRkeEpFWlpBQnh4emIr?=
 =?utf-8?B?WFEzcGFaakhZcmFzeWJVN0tnUVdaMmxIb1EzMmdXeG9Bd0hETWt6b2ZPWExw?=
 =?utf-8?B?eFJNRThoanN4azNnUm5HbWtDaFVzMkxESzAvNkJsbFRFYTVlU0ZyR25SUVFU?=
 =?utf-8?B?MGV0dk0xbXFxMStwUTlQNUFhbFNDUk1SZ0xUd3R4UVJOYU02RXJIQ3N1S1FC?=
 =?utf-8?B?QmpwaFc1OG1EbTNINUFlSmVzUzVBMjUwN2JSakR2UTRPcGtabUkxL21VNlp5?=
 =?utf-8?B?dGxLS09MNzFJZnk3b1UwbVhpZWxGcEtBaFZSRVRDWTJUNTNYeFFKQVVFeXVN?=
 =?utf-8?B?QkpPTFEwMTRQaGdzcHNXODVzbUJyQUsrRUlRUy9JdG9JY1FwTnJUNzQvSW9E?=
 =?utf-8?B?bmZvRVVmRjlLemNmamlDbjNWaEZzYTBBdVBONnFXdmx5YnVSNmQrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3a537c-b286-4014-7e75-08da277689fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 11:18:50.5814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liKpM10SUEKrCeh2U42vKrU81XmBDdMgN3O/sz0yAo9TVCbJBzbUBGOuxvDDBVR1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4844
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/25/2022 12:22 PM, Prike Liang wrote:
> Without MMHUB clock gating being enabled then MMHUB will not disconnect
> from DF and will result in DF C-state entry can't be accessed during S2idle
> suspend, and eventually s0ix entry will be blocked.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index a455e59f41f4..20946bc7fc93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1151,6 +1151,16 @@ static int gmc_v10_0_set_clockgating_state(void *handle,
>   	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	/*
> +	 * The issue mmhub can't disconnect from DF with MMHUB clock gating being disabled
> +	 * is a new problem observed at DF 3.0.3, however with the same suspend sequence not
> +	 * seen any issue on the DF 3.0.2 series platform.
> +	 */
> +	if (adev->in_s0ix && adev->ip_versions[DF_HWIP][0] > IP_VERSION(3, 0, 2)) {
> +		dev_dbg(adev->dev, "keep mmhub clock gating being enabled for s0ix\n");
> +		return 0;
> +	}
> +

This only ignores clock gating requests as long as s0ix flag is set. As 
far as I see, s0ix flag is set to true even during resume and set to 
false only after resume is completed. Is that intention and is this 
tested to be working fine? I suggest to keep this specifically for 
suspend calls.

Thanks,
Lijo

>   	r = adev->mmhub.funcs->set_clockgating(adev, state);
>   	if (r)
>   		return r;
> 
