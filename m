Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5146CD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 23:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DCE10E0D1;
	Wed, 20 May 2026 23:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IYvCM3qS";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A952510E0D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 23:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuPKx+pcRQmX6uJmv65eEPNESQyTtgNd/6lz4ZTTZXi+zVxGE29s6/HkYss6pYOARaAkCxWMEn3XBYAoDRMtg0fOlMN/vycHAMauWOf9gYkBnLySGulTIR7/2Aq/hnMgBFPDiS69/2dU0W0CRoV5BNwHhVjGrSgI6VVCBdlPdgGk3gZyWCHi5KRibvYWrOU7S337mkWarp8jcvw5mElscAGYLzYUBxRuaMTqs6JGVoXljUqT6NBGXwHBZajKtqJ5pZSTaFx8srxMNBpXPI0XVlSte4Sx4/VJOT3GvNpYnmc2HbeeoJlUXtHJ3d+2PDX+RvntZvV10GRYuhAdz2dYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnjwhQYIEFmfucm7hAfrzwcyVIZdZAjtdwp1BvMkm5g=;
 b=XTPYoxR+ij9BPdmBGbcdjCFHY2afklpWmFAIMxpdOfF1tGqChGBdr0AQvdOL23omg7Y0DkmfAEwhnRV9uUds/lNq5apNgepaF7wYQD0pFMQgk5gXcaIzpqOn3fO7YNjuP4kaGWG2vAr81lCyErFlonokjMVEAfzG70pYJq5KBAsR249Ls0F6v0CGpT30YC6qFAs89uZBq6B5i6rjvM+XxfXvQsa+0kfmrfQy/Xp99E/qIL5GBXskkCbh9qkdDGoQ1JHqtsJTVi+5Fbiw2UYSUO94SY5l+54dHfBw7r3G7kBOutVIlBq9XoEmdqVF/f+2XpKbfnk23LeALXT4Ur9YaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnjwhQYIEFmfucm7hAfrzwcyVIZdZAjtdwp1BvMkm5g=;
 b=IYvCM3qSbqDBiK5Kjz+yd60JIL7lmh57Y+Y5Ahbk6/eMPuCi9pzPlNGubRCBgbTWaDeOau0dKq3GNi2ojIaaMtl1L0b980mdaZwWQbAGaxhPEuomKJJgLjM6sg6VxMyXDo2WNJH9LP1j6zxhrHZQPE4q/UxztMdeEQmoQ08YWPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Wed, 20 May 2026 23:15:38 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 23:15:37 +0000
Message-ID: <4dcb98b1-ebac-4c0d-968a-aa30fef0d67f@amd.com>
Date: Wed, 20 May 2026 19:15:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Change sigbus delay value type to u32
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com, David.YatSin@amd.com
References: <20260520071336.1573860-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260520071336.1573860-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0424.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::24) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: e78a829e-1d39-4902-3a90-08deb6c5b3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: +PKSUCD7hlJNXor/4lDLYWTxRh7Pl/VwcEI6PrUo2KOF2P0NERiogWf96MlR0A8HiXXX5UgAAJGI7O1r0BF4bCzMnzmnI9oNqkEt6rU0ENE+j3tnW4zSJDRkkSlVKQXhr/KI5ETTf1vyZSBB4WVtsqs84q0WKCztwGj+XoiEvI9LcGzV7/1pc6ZGrDsBN60KUw33Z8oqeSXWKrIFwWUaWdxjaRgVkVlfCiZ3/7llujpXlRFgArAFbIb568XYYXFyLkyy3ZDCCacM6H9rq7cYOgtiqArwBXBzndosFJC29o41eY8OGk1WZdUsrUG310Q+Xn1I4rT6ofaBHwblS8QtNLkFuhqjrZ7bgwcFeM/u0JEa0jDs3tcwSQU5BTXqVSoOObA48yZ7gBqibCKyiI9pKn5qU3rVccMbSkWIe+pr7Q3PJU97laA27STxLkURhET1IMVOPnaXE/PkB7QxWQEFgWaxQ6Xaphn5p6a4G1EBqSiw/KrR7L8v+h+qv/5NseOFZjzxWqZC4paQFlAYKAxpir3qanCGrG2fnYigWsnMyJOkeRfP1DglJe2JX12Yieb5lGElu8P7ALqMmT6sNIcq8jOx0iMjx6DwVyRuhbWFkB1CPe9Lzq2ZJdK2hvR+MW/6kOHaalPXp1INu1SQarYbYi7BIevDYngRWKy5C/osaVlSUPbJhHjvAcRaMV+mrPdZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGJ3d0wzMnZTMFQrVGRjTUFBekUvelRuRmMvTGxjckhudGYreTRjTllJWmVi?=
 =?utf-8?B?elUwUWVVK3ArUzVqemNydGYrMXM3dlVGQVVtOXVVVmpLODhkd0I5Sit3OWtO?=
 =?utf-8?B?a0I2NDBwV2lhMlliRXdiTlozeGFZSnBoajdVa0lMOTNXZ003dlpBT1F1QVoy?=
 =?utf-8?B?TXZpK0NnbjEraUhuWURaSzFKWEduNnd1MktSY2p4RWNBVStsQ2VmVndqWUlq?=
 =?utf-8?B?aERzdDhCSmI4eUxRcy9VUUlUbnBPbVNJYlRUQWU4NDF4KzJ5RXM2SFJ3OTd3?=
 =?utf-8?B?VnRRRER6STdlN0RHRmVIRXh3dXVEcGRvYUtXMm5nd1gvTVJkb0Q1S2NiZUk0?=
 =?utf-8?B?TERjaGNxNS9QNC9RSlVENjQvQzl3QXZyQWY4cjB3MmQrV1N1Q1BNQ04rQWxr?=
 =?utf-8?B?TVFad016TnpPVVY2SitHQlRSRzZqZXMwcUFmQWRQS3BabUpRNVJQNmhnU2Nu?=
 =?utf-8?B?ZTAycHRCTFl6ZVJpbUMzNHVmRXZTQkMwbkdVazhqWFpVYlZvVVNEdWgwSTRl?=
 =?utf-8?B?dmIyK1RnSmhUZ2E3VDdIYTlMa1FYUERuU2lsMVFOQ2k2WkpCVGNNK0JhR0dm?=
 =?utf-8?B?MDBncFpVNlpvTlRoM0llMXR3aHp3NmJ0THptVUQ0TTVaTDFsZHZyZ0FkdHVL?=
 =?utf-8?B?aHZKcCtCYjFpMkFPV3VMaVIzUXBtVmZNN2xlWE5aOFpXVkxjalRhVHY1d3Bl?=
 =?utf-8?B?M2wzbllGVUNmVURIK3o2SnBJNUMyQmtkcnUwVldjdjZJdzRlRXAvL1VpNXZT?=
 =?utf-8?B?WllySGFTbTJzWXFyUW9MWENiQkdwdE45SlNsV29oQ1VId0FvNTlsQ1R4RHU0?=
 =?utf-8?B?b3V1bjMvTi84dWtuYkhrZjZKc2VaU0NiQjlNNGp3ZHpib3dHQ1hQZGRBYzdI?=
 =?utf-8?B?amR6R3NTQkVlWTQrU3p1Z0Z3Q2Y5VVFZYTI0d2cvU1BHV3h5OGhRdFpnMktF?=
 =?utf-8?B?alZwcWlMajFkSEhWUVQ0ZzQwT1MxS2YrclFLbHZvYm9xQy9XMUUyMDZSSTFM?=
 =?utf-8?B?YVlEVW9oeWR5Znora3hZQ1JoRllCTU96WENyMEpuM3hoc1FReVNIM09zcEdC?=
 =?utf-8?B?UGVhYkI3R2MvZUZxSjhBczhlSjVWYnltRXZ2MjZDWWZVbWNzUmVUc2tvZHVl?=
 =?utf-8?B?OXhPUnNZQzZUVWRubmNlWTQ3OWhGVllsb3N1VGJ1L1JtWVZ5WlB1VnpNZnJ3?=
 =?utf-8?B?Y0tNQ1hGRWhnVUt2bjhjWVVQRk1tYld3RUFDOVdVOUZ5bkMzZnQ2MmVVdzIx?=
 =?utf-8?B?dGNzRjhiTVdMei8yQVpOOFJFLzMrc09XVXpsOVU2aUJIRUs2czRpcEpEYmVR?=
 =?utf-8?B?WCtNQm10TnR5aVU0L3c5SEtsK1ZJaWhOaS9EMDdPVnJZdmdaUjg2SjdQcytT?=
 =?utf-8?B?T3JjU3IrZ2tGNDRqVG9wc0QxZy8xMVJzdXJxSkt2VDl6ZWM2WHI0cUlXdDBG?=
 =?utf-8?B?MWhzRTRXQ1pzdXhaRGtiUXNwRFJ2L3hFNm9uVlltK3EwZjJ1VDB5V1J6UVNk?=
 =?utf-8?B?ZWJHQmVHWExHbUN6Smh2WXNXQitTSm9Uc01yUmszSmhWYzd2ekZtZy9qTDlE?=
 =?utf-8?B?OXpDaXhidXdUNGdxTisrTUs1UmFpYVBVZ1FSTXV2MFhHVHZoNzRkeEZZSkRT?=
 =?utf-8?B?bGd5L0xwb09qVzNuaUpVM1BIVG14ZHNhRnZVZXVPYTVEYW1zYUZBNlJYM1dU?=
 =?utf-8?B?aW9yTVdGb0FiaGJJWjFJcHYrdk9neit4Zkh2UzFCakNmK1IvVWNiVDRiRDBY?=
 =?utf-8?B?QUQzQlFZYUUzaVgvQ0F3OFl4YXkrcWJXRGlHaVY5TDJkMDlENTVubzBPOXVF?=
 =?utf-8?B?Z0NMbWNtSmU3WWs1S0VKRlRMY011TG9tTW1LU1NhTVRpRnVnSzk1U0g0M08x?=
 =?utf-8?B?T293UDlQYTdVTmh0WTlSSnRSVnVUaXdWeTVhUGlQWlpZeW14QjR3Rjh1blJk?=
 =?utf-8?B?NXFLWWQvb2gxTW90NXp0TU9TeW4rNHFlalpSV1pURTFTeDlzODZnZlROelF6?=
 =?utf-8?B?bU5kSVU3RXozZ0pZWVhqbU5XU0N6cDNMd053eVpCT1RKU3lSaTFNa3I3VjFX?=
 =?utf-8?B?a0F6NTI2YW9BTjRHUWVnVEplMWh2ODJmUUIvMkE2SHRGeFZUSVhnbExPblVB?=
 =?utf-8?B?S0ZQQnd6S1B2VXBNK2xQU0RVb1FoZFhtejZTRGxQV1NObUFJcThldFhSendj?=
 =?utf-8?B?NEFVRVdTMm1rZkJBdCtJUExHU0UySS90Y0FMejE5L1c4NnhtR2QxSlNrR21j?=
 =?utf-8?B?ZGRzczVDUndzS2RwOWhYR0NYcFRFckNaVzJ3VG5rRUl1L3NJWW05VmVUZS9m?=
 =?utf-8?B?UndSbEJIRXdYcE1PWWg0VEZqdlhCdjZ5TWVhak5JSnJiQzZLSHZLZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78a829e-1d39-4902-3a90-08deb6c5b3b8
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 23:15:37.5065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWhSdtJRV0W630eTJ2fJRpttVFg2xTbU7JH4vg0Vt+xMQhnJfskbVsqGallSD7TAqwY7pDKeX52yyGNaj6wZnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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

On 2026-05-20 03:13, Yifan Zhang wrote:
> Previous u16 type may not suffice for GPU coredump.
>
> Fixes: f207b038bc38 (drm/amdgpu: add ioctl to handle RAS poison error)
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 10 +++++-----
>   include/uapi/drm/amdgpu_drm.h           |  7 +++----
>   3 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0408476f1070..6a5459b59af2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -461,7 +461,7 @@ struct amdgpu_fpriv {
>   	 * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
>   	 *
>   	 *   0          - send SIGBUS immediately (default)
> -	 *   0xFFFF - suppress SIGBUS delivery
> +	 *   0xFFFFFFFF - suppress SIGBUS delivery
>   	 *   other      - delay SIGBUS delivery by this many milliseconds
>   	 */
>   	atomic_t		kfd_sigbus_delay_ms;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 200570401f51..8b4e0a208e86 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1352,7 +1352,7 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>    *
>    * Encoded value (set on any of the process' amdgpu render fds):
>    *   0          - default: SIGBUS immediately (no opt-in)
> - *   0xFFFF - opt-in, never escalate to SIGBUS
> + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
>    *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
>    *                handle the error in time (safety timeout)
>    *
> @@ -1388,16 +1388,16 @@ static void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
>    * Rationale: if the app has explicitly opted in on any GPU it uses, it
>    * wants the chance to handle the error in userspace.
>    */
> -static u16 kfd_get_sigbus_delay_ms(struct kfd_process *p)
> +static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
>   {
> -	u16 result = 0;
> +	u32 result = 0;
>   	int i;
>   
>   	mutex_lock(&p->mutex);
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   		struct amdgpu_fpriv *drv_priv;
> -		u16 v;
> +		u32 v;
>   
>   		if (!pdd || !pdd->drm_file)
>   			continue;
> @@ -1420,7 +1420,7 @@ static u16 kfd_get_sigbus_delay_ms(struct kfd_process *p)
>   static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
>   					 struct kfd_process *p)
>   {
> -	u16 delay_ms = kfd_get_sigbus_delay_ms(p);
> +	u32 delay_ms = kfd_get_sigbus_delay_ms(p);
>   	struct kfd_sigbus_delayed_work *dw;
>   
>   	if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index e88d7cf53858..e0a382673b90 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1680,19 +1680,18 @@ struct drm_amdgpu_info_uq_metadata {
>    *
>    * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>    *    0:          Disable sigbus delay - SIGBUS will be raised immediately
> - *    0xFFFF: SIGBUS will not be raised
> + *    0xFFFFFFFF: SIGBUS will not be raised
>    *    other:      Set the sigbus delay in milliseconds
>    */
>   #define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY		0
>   
> -#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED	0xFFFFu
> +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED	0xFFFFFFFFu
>   
>   struct drm_amdgpu_user_options {
>   	__u32 op;
>   	union {

This union only has one member. You can remove the anonymous union 
around the struct.

Regards,
   Felix


>   		struct {
> -			__u16 value;
> -			__u16 _pad;
> +			__u32 value;
>   		} kfd_sigbus_delay;
>   	};
>   };
