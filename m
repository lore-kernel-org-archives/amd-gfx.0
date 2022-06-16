Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54921C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 14:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA64112E9E;
	Thu, 16 Jun 2022 14:49:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B37112E9E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 14:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du7mS87nyGGTYThJ+LPI+lgQPknE+Nl4ioJMlLKvz+mmNxl4dfg1JfRA/XS6wuDQsuuoIyWDFvcEJrf4Sagl/EiXdvl66dANUkmxPFwGngvQBpHWnQcBapA8k4Fywvsr/VCrMzlsJnCFJUa3o3ESAI+YV+TaZQEGfWElAcVcM7LEJPq/aL0QkelXNl7UqGfGN37lNUrixm7K0/EIkOxx90B1wwDFdOgcl66kcp5ap4mdixcvbju7w2+DvAlX06lpj3/sdCTGCIOdWNnF4q3Oph+4Enp/bFv4yDsuRnkcOd03ZhjFpbOgqCnxozPGRrHRad+fJuer7p5U2EPMaHPItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7in+Yb+x5nGU9+vYDA98KAyGWjtg5QUZkS6jnONYFPo=;
 b=cY7c6z0P4iobR7Pcmd3vf/3aJtj5EHDSpOpXqRiop/8OzYfbPPT+jkgImL6j2tb1kv942S0y6FpfFbF/PQucXUAaoqeL1dGm6IezFGNNHj8RaXITpx1nOZQDgGgsoxMnd4GvclQ0HnfDRQTwCLY0h94xW24ggZHrPeMtvEUIJVuJVC6z2CJitadAKAbQSLPngm73Q8gQqFWRDVy0WLmkJme77neHoqXjTL3uwhw+AI0wkyt7xofem46b+D2jCJXltkIPDXEbd0q5U1OnKWnShPedQnnTS1fBT0np2nW6I5eI/mUQvQHnp2nqiQ6HYAKyCZP+YpKLPfi75tZgdtNziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7in+Yb+x5nGU9+vYDA98KAyGWjtg5QUZkS6jnONYFPo=;
 b=r40X6IG/aVuVMdUSEjJySzpQG3Ut3nwRfTv/skGqFF/222eRl1ifGohgEjrf2sPtMiWkGiaqcrfUsb7AHT4Fmt/1eojxaqU4Nf/tqsi8u1CsBmH9zWYU8ZO0Fqe7YeG1jGMpPfcmxY9bF7RsxYkjbWC8n6HvbYZiJe7nrk2yUU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 14:49:39 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::39fa:4943:168f:7629]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::39fa:4943:168f:7629%6]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 14:49:38 +0000
Message-ID: <a70defa4-6268-406e-ff69-fb5f8aa6989c@amd.com>
Date: Thu, 16 Jun 2022 10:49:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] drm/amdkfd: Add queue to MES if it becomes active
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20220615215651.14502-1-Philip.Yang@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20220615215651.14502-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:610:e4::17) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee689d87-08f6-457a-c7a0-08da4fa77020
X-MS-TrafficTypeDiagnostic: DS7PR12MB5935:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB59354283A145D9B27DE31FC782AC9@DS7PR12MB5935.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTar7w3MzRNQfu13P6LGzBiRYymEs+t81by57lpdvi723q6+7pxrof7Ja6KxrUlXGEnsk8bvwip05wvTIshrbZO5ajKnkI6Ta9zmBwHd8s6+S6a6SD9Z1kzW0urm+Z/qpnuq8FQkAP8hlQlPR5Eda797Sz+EFgvqF6zbQfLlVPA4e7Y5LzhOogv0GtfldxIqFnu1dR7NkNkEe0q2WAvtnrw/lNaH+MPtceFDbby5URakNZaMoECVFSz28wO2frmZjDUI3loH97GjUXhB1l0QQ4EuevMjUE16K2aki+zgGh3hxJp/rfoBKgfWatNBW2HAHRIxcHXI3iE2b3SFa7n2rJxZsJoF/ToupXxOL0KPdEL3O5ZkfrBkU8n4/SM9hQBikjqgzVQKdKdTP9ZtROT8pYU7VYtVH0I6rg5xH+q9+0U537I5DbHdKRXchLwoLTDk8msVSGrSY5ZI9CJwZWeZJaBiHRrD6Bl8CsSpGhyd8OOB6mbC1ML73hz6+W9xkdEQ8Xf1lZhhhgYJhSQmI1JcQm1QUCMJ2R7MdSnawlRNeSlyViOJMnlmubdsf6PmF6LrqV7qPwx9AbDiGhTJxlCyCc44lsUMzu2a51l8+SyMgwEWLowFRVuCoWBPMbCSlPjeIBE7gjcPKTJp1hb6VS83AUh448DNO0k+u1tfgiUcWFijw0tiuW/0jKRbPingR+LjoekvfEnlmA99Xc6Tf3VXqOeTfZL5fBrm9mMg6iUu56I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(6862004)(508600001)(6512007)(8936002)(5660300002)(53546011)(6486002)(83380400001)(66476007)(6506007)(8676002)(2906002)(31696002)(2616005)(186003)(66946007)(38100700002)(6636002)(36756003)(316002)(37006003)(66556008)(31686004)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTR1b3Z5NnN0UjdSMmVRVnpKK05GOXg3R3pOVXFiS0FCa01wYjlLNnhERGg3?=
 =?utf-8?B?R3VGZkFVUW9ESXd1UC9WRUhvczVOWEVuTFg3SUMrTW95YldTRFVqSDRqYmxa?=
 =?utf-8?B?a290TCs2d1gySjBMc1ZIamJXYllMUzg0bVA5UHBjdXhTNGFlOERla3kxeE94?=
 =?utf-8?B?SWRnclhGazhNZ20xN1h1aHVuZVAzVnhwUmZiUFZCTFE4cmRKdnkxN0RhZ2pX?=
 =?utf-8?B?dE96cFF5eWlBWmU1N1dwWGpiSDcyRVNuR21ZSU1mNDVqOWZIMFFsZU56d3JW?=
 =?utf-8?B?d0dRa2FMNDBJVzV4aHovd2F3YVNkV1FFSnZYL25WYng4TEdiRHhPWVB0blBn?=
 =?utf-8?B?NllqZ0grUnF6Sk9pVjFzZGtlRHNSQ0F6WjJRZGN1ZTVkYXovOEI0UThzS2FH?=
 =?utf-8?B?Z1pZbVBkNmVsTmFtUnNhVlh6VjNOL2xoU0lDV1R4YU5JYXN1c0pmdVF6NzU5?=
 =?utf-8?B?RjhQMkNmNHV1aEQ5U0VRZ2IzMDgzR1ZuSE1DL0NZSGtJZEp1ZjRLdzYyTlB4?=
 =?utf-8?B?dU84VHRYL21iSHJQcVpGMGtwR2ZnSFhHcUQ5ZEpSRVVzVWttNnAwMS9WQWtq?=
 =?utf-8?B?M05iVWdNS2JZbGJwYXFEZXhxTlgvdGl6U0EvRzFkc1RXZ0Q1UWQ1YmQrd2No?=
 =?utf-8?B?aHJTaUJ0a2JPMGlTaytPSFhFQnhJeWFlWFJYRnlodjBTcWY2ZTgzcWNyQXZj?=
 =?utf-8?B?T0h0NnBpV0tNYm5vVzRhN3l1ZFFnODlOVExPNU03ZE9UM1N2Z0JqU2JZVnkw?=
 =?utf-8?B?U1ZBVVJGaWpmakVnYS8xamh6Tlo5TjZVMEJlc0c4cy9NWTdtMnRnWDRSRm9I?=
 =?utf-8?B?Y3J4cnUwODNPeVp4b3MzL3czK0FIaitUZWQ5UnNsNittR0NNUU12V1dhZ0NZ?=
 =?utf-8?B?bUJSOTNrU3JUYTB4U1kwTGFoZmFHb1dyVDVFUUJxWEd3NkVNV0RKdTBvTzNR?=
 =?utf-8?B?TGYxYThHZmg4bFpReFhTcnp1ZExoQ3h2NUNYQWJZa3A0Y2IyMEhoNFUvK1dK?=
 =?utf-8?B?ZWlvMXhDbHh3OVZuQ0h1S2Y1UGdIYzY2bElvSTRmL0JHTi9ZTWN2ZWhFVkdU?=
 =?utf-8?B?ZUE3cFhMQkZqa0taeVp4dDZLOERIUWRRTlZidnEyTGh2YzMwT0ZaSStNQ0o0?=
 =?utf-8?B?S2ZlWmtqRFA2NHBnQ1hJUlUyNGZmek8rVUhLV3grN2FMMGU1NlgxRFBmV24z?=
 =?utf-8?B?YzJ1NU5vUFVRUHVRVmNwSkY2QkJBQ2ZuQzJKbFBKdk9MbzZpbFU3N0hnS2hS?=
 =?utf-8?B?cWpnWkpjdXdRSDVtdG9kT2RTa1ZlZzFpRS8xUzRTai9uWjlrYUU2MVRhSHFa?=
 =?utf-8?B?cEtUTm02R3htSXVhSnNHdUJEWDVERkRTV1ByRnNITHBiVVY1NHRsV09TbVlR?=
 =?utf-8?B?YzNpckovOGxRUTBGRXp4UmVtbURyQXJvazFXc0FwR1EyRXpFNXRXSGpCWlFW?=
 =?utf-8?B?QXk2R1JIaXlqN3o0a2FRRkVpbWxGVzREVDA0RmZNZG13TUxIbktGZ3JoaEtR?=
 =?utf-8?B?RC9YZGtQbXVpL2N2Ry9kYk9xVzI0VnI1bkV6N1VrOENqRHl5ZGZ6Y0dYQjYv?=
 =?utf-8?B?SDNVN2dlNW9xK0UxUGJYajZydXZEMVdraEdqaTlSLzNMY0RVWlVZUm5sQVRn?=
 =?utf-8?B?bGpKeVR0M2I3SUJReFdmRUsyeE5vWTU2NkRLSDluS1FoTDMxL2w1R1oyd3lT?=
 =?utf-8?B?cC9LTlNzVGF3Qk1mMk5qclJCODlEUmpVVlBOcHhJOUNoRnVGa2htcnhsZWl5?=
 =?utf-8?B?enZZMlNvN3hLU01URjIxbTBaWnk4WXllZ3IycWlRRzQ0eWR2UXF2b1hGN1Qz?=
 =?utf-8?B?cythSW5LcmhLV3BCdytVblR0YU1aV0VmbE1OT0hmdVdsSDFmeXkyeFZ4K0Ur?=
 =?utf-8?B?STdTNWJ1dDdUd29pV1RWMHFOb1MzZmdBQTNyMGdzajBiQmcyM2ZNWFJWbHFV?=
 =?utf-8?B?NWdtUDVucGpjTVB4YTV6bHBmQW1ucEl3K2Jlak9wMTljMzg2UEZKY0lwOXNp?=
 =?utf-8?B?ZWZMSkIzQjVDb25vUi9ZbkpWNHZKVnNKZkxmRnJjNWQ1WVFnTVcxZTkyc1Vm?=
 =?utf-8?B?SE13YUd4aG1iOWRYQmVRQUh0b2hyR2hqN1FyMW9ONGpjdFZDUzlrdkVmMXlv?=
 =?utf-8?B?TEtVOUZiNzJIVE5rRmwxRGpJRHNpRFkyUWdvTU1Ha2xKY2ZRL2FNeVh4SjZQ?=
 =?utf-8?B?K2VrRGRrYi9iNjY3RUhPSGZoV08yV2tPN3BWSHFhR3FKWThWVTYrYS81T0Fx?=
 =?utf-8?B?b1hISGx4YWxmQzl0cnVHUW5rdFRWTXQxdlJJdStrQjYzek8yemIxTDlpdTFp?=
 =?utf-8?B?aXN2cm1RTDZyY2lxWlEwbWFqN0l5Z3dtQnRURDFaUUdkajE2Y2NRSEpoZTEw?=
 =?utf-8?Q?KzQCjBjCBxveJddOoZqWKzugQsnxpCPEHUd5EipWZwV0B?=
X-MS-Exchange-AntiSpam-MessageData-1: QqYNAHZKUuYuBw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee689d87-08f6-457a-c7a0-08da4fa77020
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 14:49:38.8330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wE+eb5aoQx1KuzoW5rh5TRgs2teEprBWNFRECgpis1AcAy18ZgSPFUTlNFGF3z1ggGYpAYPD6Uh0bYCRNw/8yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
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

Does it break the case of q->gws with q->properties.is_active == true?

Regards,
Eric

On 2022-06-15 17:56, Philip Yang wrote:
> We remove the user queue from MES scheduler to update queue properties.
> If the queue becomes active after updating, add the user queue to MES
> scheduler, to be able to handle command packet submission.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e1797657b04c..67ae5b6385a2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -866,8 +866,10 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   	 * dqm->active_queue_count to determine whether a new runlist must be
>   	 * uploaded.
>   	 */
> -	if (q->properties.is_active && !prev_active) {
> -		increment_queue_count(dqm, &pdd->qpd, q);
> +	if (q->properties.is_active) {
> +		add_queue = true;
> +		if (!prev_active)
> +			increment_queue_count(dqm, &pdd->qpd, q);
>   	} else if (!q->properties.is_active && prev_active) {
>   		decrement_queue_count(dqm, &pdd->qpd, q);
>   	} else if (q->gws && !q->properties.is_gws) {

