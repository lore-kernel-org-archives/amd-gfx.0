Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E76C25B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 14:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D6DACC02;
	Tue, 16 Aug 2022 14:18:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9177918B41E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 14:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNWvNB9iyL0DtBHu3VkhqbL7+9xHGw5Idn6xiQsGHw4+2SVLZfYPdVV4cmfvKKfOLZmVnkF+3uWnADPGWSenavAwklnD/SGkvG6NnXN21I44V5KNdsKNr1QJOYYSlTKVVJ7tFN4/8euaLXcYoodEBpHP8iaiGqjaWk2cGmzz7YORrpYz87sh1Q8hGDSasQdkyBtJp+r1bqJspxt/wApbCWytgVwCqDFPzxOFhZv7AyYxzNIQ8inKxrb+zVIoBz76NJA3T8rOjopsS52yYLRqcPfjonR2ezkNx35LfDFtuL1Mm1ZLpt2rpvYjb7MMulQEjG8zH+QIAXOjuz+bBjCnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLhsuq2qsJI5A21JaBQafjv/Q1cIxLZ56AVHs6xwTo4=;
 b=apmPu3a7KfpolO0UbVWdL+0wwyXjVcZeeqTWd2RA7I7EdUij2RafqX/ue6HoGiBxtaU4ISQ5pSCbiCb+W9KtGRYYi3rBZZA7hnQs7LLxdnbY+peL1bwj/FHH39r21BshFjww4BQNn+CV+jBESUwYZKizOKbBHIrD+F7Cd6TOahu+jqk3gPjSUqB+vQIxuXdfZavmrp2BVFq7cty/C5sv7iWdsblNwnmtcarUZLt+97XsK3RTpo4rtzYEuYiapKw1P1cfj+zE1vB+TWudqG52ipWKlDxsAfifh2W/aaIjov2/EpdeaGl0rfGfdiBMa8M5bUpY+ltDjguHB0+ExBPvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLhsuq2qsJI5A21JaBQafjv/Q1cIxLZ56AVHs6xwTo4=;
 b=zN/Gxdw/WC5f+V4oK7xOK3+/qVQHwSevQzMgJlD4PdiSnEor1JaViJkXoof/ikBF4U9NjjNYPcEYFf+f9TPlyKILyeUG0n7geDL63VbrSj0DPyNn3GI32K7yhKcrd7saNx4Oi0evsZiJfNY1Erq/BMIDjzdErHfEt1WWc8PPF3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Tue, 16 Aug
 2022 14:18:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 14:18:31 +0000
Message-ID: <232c643f-33f9-5b37-2329-e0e0b46d6219@amd.com>
Date: Tue, 16 Aug 2022 10:18:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv2] drm/amdgpu: Fix interrupt handling on ih_soft ring
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220815192557.3348828-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220815192557.3348828-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0278.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 190ab78d-399a-4f84-44dd-08da7f923228
X-MS-TrafficTypeDiagnostic: LV2PR12MB5871:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKwOxCmT9IXWul7V8tkDZ70CgqTKV/9e0Z/vIR06OtekMH6SHUJcW+lec9khlj8h016dxGo1Dbtn4JgqxmtbZ9um4NwBlYN7+Xq9M91+Hl5zNUTNn6khX/vDVRvgKQslm5oXqPs53hLjU0yQKqd/vJunEaNvuQHkqPD4VC6Qvw6SDH6XkldKu9NpsMFlcW8SLbaRFNzH5lT83xwVEta1ObjzcvXJuDN7JLbVhoYeKwmltXSXPFLG5jviwTzpwiIeFkZYN4CJnA6KZv9mEVnM1eqK6/Ky3ApWDtaeMC4o4JDpEbr8m25mqG5l4WGeTrh5NnzDwlfTmYPk03+m2MUzLj459GvPsTy+LL/QB0DEGYQ/+P1YQvIaxbgP/HouYD9+iekltgDnt5XVwSA1yly+MOV55vokb9QqZskpCy7Dd1dgrV8ar+IanRIVASnyyNooq5aYYV+1dfwEjoRDARO1/95I3MEuiY8D1oK27+Yj9oTY5k6zORTbRxyAcVl4wlaMuoQlq0CleL3NgOVP/R5VvTeoPxzOdyOQ2Z8Uu4e9r+3aPcvz5gH+Sc4glXZ3VhKYxs9UcVvId9Dl1YwQRaLKbCYxjvFKoGndN6tzaCXGKzJYQLikFo6ex8kvnx8Zm42Z63YWPNhaL6o+gf12DbJ6HaEVCE3c1Uo22P8PLJrc3IRlyCJc8fptwIehOzVnXem7egwB5njbfv+hSlIrJaGAaQYpwZxAeNCuczXx7ZBrELPVI23m+faRwRUxfiwIfJe3VEATZ8qQ9VDZ+pizwY1S6zc9kpxHC9WuzYPzi566Neevf4d9W9CQoJXTyIYWzQVuzilIoCWlgVsJzENwQ3zV9RJ0BisSF3ipGuSMOr2sWBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(8676002)(66476007)(316002)(66556008)(66946007)(5660300002)(8936002)(44832011)(38100700002)(2906002)(36756003)(31696002)(86362001)(6506007)(6666004)(6486002)(83380400001)(478600001)(41300700001)(26005)(2616005)(6512007)(186003)(31686004)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBhVVlJMzhveVBaSFpyejIxazdXelduZkxxenNTOEFtUWt3bzQ0cElHdWdo?=
 =?utf-8?B?a3AvNjBSNjA2MlF0dW43dUFqUmpwZjFPdjZQNjdIVDkrSVhibnNBR3krczVq?=
 =?utf-8?B?eGtTWjJSeHptRnFSeVY1SHhSYzhoMDQxMVk0S2JZbi9tN1ZxYzhHNC9zVk82?=
 =?utf-8?B?QWlaelFJOEtuaDlTUllZVHhMTGhtUXJjdGlCZGF2TzMwUFZFTnhUZS9pYVF3?=
 =?utf-8?B?VHU2dzZNRm9kMzI0MWN0VFA3dkRpSnNZMlROQ2ZuNEdaeFVXY2xXNTAzMXd3?=
 =?utf-8?B?TnVzSVNsejhaNk9neUhGZTZzWUtWb2RQOWFOU3IxWG1pd1N6QVZaN3g1cWlh?=
 =?utf-8?B?MjRrV3B1WWI3RVZ6T2lSTkI5Q1Z1cVlRU1QrMytEMVBJOFZRYldmL0VBSWJv?=
 =?utf-8?B?VXZXYVIwK00vZE0wMU5SMU1yN2VOcVhNZ1p5WktKaDNGdFR0NkxabmhtR1Vp?=
 =?utf-8?B?WWJPaCt2MlBTRStFa1dBck1kWlFFY2JkRnJ2VFB0VUNXaG9FUkFEOXgzdWYr?=
 =?utf-8?B?bUFqR3M0dkhJUjRUU3V0YU9pM3FFQzdsc3cyNzBRWlpoRHd6anZySkFMbmpF?=
 =?utf-8?B?M05zS21rZHJ4b1A2cDNMdE9hTXZRd1JxYlFZV3hpbDRRdmkvV2xIM0V1ZEx3?=
 =?utf-8?B?K1dVaTFYU1l4UHp3bmRuRXoxLzVLYXFhQ0p6d0hmTkRPN2FCYnVoRkl2OHU1?=
 =?utf-8?B?eVlnS1RFOWU5aE56RnhrQWNBeHV3NW5FQ3NxbDVXM0FPTnR0aEk3Ky9yNUhI?=
 =?utf-8?B?VUxxWVA3VlVoZThYbDdtLzRDNHRvOUFrSTIzbnduUHh2QVNLM3gwOStFdnhB?=
 =?utf-8?B?SXhab2JaYVV4UDB2WnBLbnF2b1dJajVFNU1xMFg0andBQm1uN1lzUlYxTEVG?=
 =?utf-8?B?VGtJN1A1QWVFYVFTOHhQQ0pXOFNINmh3aVQvMHorRlFJUWc5MitmczQwNERa?=
 =?utf-8?B?TnVocmJTcWtjL09WRS9jTjlMWFYvSzBkR1FoRXFjcnBkWXcyaTB4a21lN214?=
 =?utf-8?B?OGJxazF2R1d0UjVNa0R2N2h5VVVXU1JpYlBzQUpCV1pjdUgraFpJemFkS3Zm?=
 =?utf-8?B?Y2I1aEs3QVRKMXFaNGJZRGhJenVHUXNvYkJJZjVjSFp2SEdVZDlMeGNheWpa?=
 =?utf-8?B?dXdUYmhkL0R2NmFKWkNNaEJGSU53Z1BkT0Z3YkhIbGNUbG9zdlFZK2NDSlU3?=
 =?utf-8?B?alhKbEVrNjVVVWptOWJrK28rb1l5UjVXVjlKRUtCVi9rT21HZmMzVnNQendF?=
 =?utf-8?B?SlkwVkJiUVFlNW5QL1BwY0V6UGU5MC9qSGliWmVoOW1nc3ovRkt4MDRVbEhV?=
 =?utf-8?B?b3RWWUpVK3kxUUgxU0NCdTdwblI3dEtBMTJwUklJSlZhZXNOMG5QL0hGL1k4?=
 =?utf-8?B?MktHTzNhQy9LNzVOSEFwV1lZY1N2MnhlRUVseENub3B6NW9VYlloZzgvbGxP?=
 =?utf-8?B?QjBHbS9xd0VLQ2Q0Kzl4RkxTMjJJTitxVXoxV3RUMWJibC9NdW5WQ1dTSGpN?=
 =?utf-8?B?bWZaOS9oSGFwc1I0em5Ia1BNODVsRlkyY2ZrNTRTbXA3V2xqNWt2ekI3M0wz?=
 =?utf-8?B?bGJ5blFVUTI1TVlHRGJvU21MVGZSM0U3ZzR6Yy9SRzFZazdHYW1JS3B4N0lN?=
 =?utf-8?B?TTdjNnh0dGg5V0VXUm9NMjRrb0YxSkpWaTM2eFJwdmZXNy93UkdPMkJvWTM0?=
 =?utf-8?B?UFJ2NWlqc09kNWt2T3YveU94RTRXQmxGa2JldG4vVUN0cldyd3grMzNFWGpu?=
 =?utf-8?B?UGhjSnFOVmdvdVpCQVZ0ZEFHUGU2MUZxTzN2dEV5Qm1Pc1U1SmpQYy9wOEtC?=
 =?utf-8?B?azdnSHlRb1VYRGxSVVpzZXR0b3kxeFVrVFFPcWZHaDdzT3A1d1dYeEZ6dWpW?=
 =?utf-8?B?RDdMREIzek9DMS90N3hXMU9ydFl0V3pFcXpnV2U0ZmRPSWUrME1mYTAxSkox?=
 =?utf-8?B?b2tLQlNFQ2pCbjdUMi9nalM3Q1h2aHhDTVh5dlJXK0RnT1ZEWTBreVlnUUlF?=
 =?utf-8?B?SmRPVU5XR2Y0dlpxWGR2RzlETjNIT0RzaDNOYW02bkJqMHRwYTgxUTBYbjJL?=
 =?utf-8?B?dGZIbm9jOHNjcDdvckZweEppL1hsaTZ0elJ1NjBqakZya0xPQzJJOXdzcy91?=
 =?utf-8?Q?J5CL/9WfzbBEQhUeSMYfIffiU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190ab78d-399a-4f84-44dd-08da7f923228
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 14:18:31.1361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmnFQ58tCqcdQVvnrI3ZPCb8QPA+4ke7kSMYu2YV5qHke5St6vul4/LHK7nXxOIx7xDpkgroaqJ1VDq+BfuRxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
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

Am 2022-08-15 um 15:25 schrieb Mukul Joshi:
> There are no backing hardware registers for ih_soft ring.
> As a result, don't try to access hardware registers for read
> and write pointers when processing interrupts on the IH soft
> ring.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 7 ++++++-
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 7 ++++++-
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 7 ++++++-
>   3 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 4b5396d3e60f..eec13cb5bf75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -409,9 +409,11 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
>   	u32 wptr, tmp;
>   	struct amdgpu_ih_regs *ih_regs;
>   
> -	if (ih == &adev->irq.ih) {
> +	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
>   		/* Only ring0 supports writeback. On other rings fall back
>   		 * to register-based code with overflow checking below.
> +		 * ih_soft ring doesn't have any backing hardware registers,
> +		 * update wptr and return.
>   		 */
>   		wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> @@ -483,6 +485,9 @@ static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ih_regs *ih_regs;
>   
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>   	if (ih->use_doorbell) {
>   		/* XXX check if swapping is necessary on BE */
>   		*ih->rptr_cpu = ih->rptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index cdd599a08125..03b7066471f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -334,9 +334,11 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
>   	u32 wptr, tmp;
>   	struct amdgpu_ih_regs *ih_regs;
>   
> -	if (ih == &adev->irq.ih) {
> +	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
>   		/* Only ring0 supports writeback. On other rings fall back
>   		 * to register-based code with overflow checking below.
> +		 * ih_soft ring doesn't have any backing hardware registers,
> +		 * update wptr and return.
>   		 */
>   		wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> @@ -409,6 +411,9 @@ static void vega10_ih_set_rptr(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ih_regs *ih_regs;
>   
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>   	if (ih->use_doorbell) {
>   		/* XXX check if swapping is necessary on BE */
>   		*ih->rptr_cpu = ih->rptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 3b4eb8285943..2022ffbb8dba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -385,9 +385,11 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
>   	u32 wptr, tmp;
>   	struct amdgpu_ih_regs *ih_regs;
>   
> -	if (ih == &adev->irq.ih) {
> +	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
>   		/* Only ring0 supports writeback. On other rings fall back
>   		 * to register-based code with overflow checking below.
> +		 * ih_soft ring doesn't have any backing hardware registers,
> +		 * update wptr and return.
>   		 */
>   		wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> @@ -461,6 +463,9 @@ static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ih_regs *ih_regs;
>   
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>   	if (ih->use_doorbell) {
>   		/* XXX check if swapping is necessary on BE */
>   		*ih->rptr_cpu = ih->rptr;
