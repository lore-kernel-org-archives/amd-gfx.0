Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1539CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 22:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F76610E7AB;
	Fri,  7 Jan 2022 22:06:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA0010E7AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 22:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkjwXjRm1lp0g33UqSCX6f+rn7TQ6LWptFMIIcPSYn5uyCFA0lal2ug2RQhzNG3vK4nKho+qkdTnQ3neMRPfhGFH6DxAQukS4bZfJDjjYR79oSvq3TtdiRSgBZtvhR1lXrkE3P3khD9AieI2OUamqWJQzbjdrKQx1pl7/8vDzXA24UL2YDc/hH8SWgrkF0SN0y50gtT6820NPLNVFw4XAFB0BIp0D+0aUQlpWUo0orUXye39E8bYwVn+HtSaJGrgY1k5tPhvqlT7oAcZXHU4DQqF0mfCVbctwYTN57SllD3TK7WE2uMiLj1Q6eBQ8eQALdpOpwGJNSPL80gZf9P94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCssgv4Z6Jlm1MrDGKg1PmY9Fk+CU1elFecYns5zOaM=;
 b=nkxD0Zr45kIHsF5P4PsZJNnE7vuKoNP/FG7ipWa5g8GidV75LbhoNzthkEmwdCjYYeFuUlA6RSl4Dr2LE3CLnBh+fKayVyLPE4SlgeOqTs6j5s+29tBvf6EM+32PKTUDXbXOuvJcug6dj5X/ajhOEB60egQB0qgsGy8U3iFfmJYDexrUS4Jg9eHLKERupMH/ilE2mgc5lNet1Qf3VAUsxx43ExfPDkoNy5K0N2Jw6wvbelqmpsWnyLZgtikK4muWt5BzZpk6FKaJITDew+XwXJ5/Oq07GcVOk/NO5WXD65wvsDMfSRbf01OK3i7nkdEEiEc9KuX0q08z/8OZwxrlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCssgv4Z6Jlm1MrDGKg1PmY9Fk+CU1elFecYns5zOaM=;
 b=FMbS7cHxTyFZeRdx9FDYMXujPWvquLBcw8OePg7sn2HOwuem5qQhAzm6gIUDkGKgxPRXKlpVeAJotgMJlYpMeXcRuM5D7Puwa9dm7vR/Ok6/Z+W5RE8yuibIfSt2OTSd8OpH2EjxpX8xUjmUfpo3Wak+jlXtxaqWUTFieQwB69U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 22:05:56 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3%7]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 22:05:56 +0000
Message-ID: <75a04210-c374-2fa0-a42b-d81e45e0f5b8@amd.com>
Date: Fri, 7 Jan 2022 17:05:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] drm/amd/display: reset dcn31 SMU mailbox on failures
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220107214010.12977-1-mario.limonciello@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <20220107214010.12977-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91a91c27-ac47-40e8-1bbe-08d9d229e0fc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5056:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB505601DE064F5C967FE18479EC4D9@DM4PR12MB5056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BswVu9sq6sFuVIUePDz9dlVLDSnLOwmV/QSHa09sI0NrTc6k8I+3Q1S0dL/D4KUWRQJxQ6p4SHQ8dRtAxTd0uDlnQEZMOlAnF0ZyTXYuFu0vKsoG7Q3HjkU2ljtCV2t4a180RppSIN/QPluWutF1Hj1cK/L/XH+QUit9lO32tanv1zb9sRC8InwxCZO2fVynYQ4YC0gkgD3A1rIlxP0ZqMIPQ2E7jfSy6A9+znH8aOm48PzpsELFu5JOSywCVtcizO/Bpe60Oa33o3/eMcmIUHcqPD9el/4kYWK2UHJfueWzFwMBwfkTt3Um4Vh4GctRlbA5sTb20NBQj56f/w8sEUlItHBWqYpGXWLBWX5MS3raIbkVXqwJ7/DboD72yJsQp1ywB8UFBkmS4SegA2rcZImsnkSJrIZqOaWiK8TUt73H8WJszenr3+v3ilWLU9hH/+UOgdmh5LpNobLdHDsSpwJTGQ7VLMweRY6GZgNRQXWzC98ihL3ShSe4mKc5KKFVCU6SSYQemCrc/7mxWyPzVxevCguMqeloSMUGVfryRlOB3hWG+jot/mkinX07KSM4Z/+9biD/oIYOB0lsyubGBxUtscN8ouGteC7bl3heRV4MG/WrH6xZYutJ9qXZE8/aukXww7HHggVcBEL1i38l/22U25EVIAve/a4/SKhS9mEZV556+j0T8B8EdgEsTuVVcdeABOW/a9o+alfkseFdmtC/ZBpde1o0TtRmQrdst7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(31686004)(2906002)(36756003)(86362001)(38100700002)(66476007)(508600001)(66946007)(66556008)(2616005)(6666004)(186003)(6512007)(8936002)(26005)(8676002)(6506007)(5660300002)(53546011)(6486002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVtT1pSbDU5MUhVa3plNU4rejdBVlFUODFjc1hKcGQvMDlIaDlEZUlqWkJo?=
 =?utf-8?B?NXk2ZkRCays3OFFjVjlialBpZFUxU1liM1hiZTNPem84aGdCRzNYeXZsdElm?=
 =?utf-8?B?S1Z4WWtjV0cyODJhVDJzc2VVWHo4OGhXM2ZKRXZ0d3RsRHU2L1hBWm1YbEJj?=
 =?utf-8?B?SWd1YlYrYldyZDRjSmt1dWdjVmZoZDQ5LzVIQ3paWE1hLzVyc2h1WnNQem1Q?=
 =?utf-8?B?SW1iUEtEUGxHcWNSNEFabmhsdkp3WkZLcXdnR3lPSlVmTkNtaDhmdFpQMEFL?=
 =?utf-8?B?MGlSSHVLZUlBQ2FJU21LU0tqVkVkbVBEdGN6RXI4d2QxdWZYbmpsOSs1Ri9C?=
 =?utf-8?B?TFZtdUdXV0dxeHpoUnpaRmFhUE5yK3BpSnBHeWNBTDZBRkpmQWZOeGJqMEtu?=
 =?utf-8?B?RHZydkdhSjJRVDk5ZnYwRUhIVEdqVjFva2IvNGl5NTdqcUZQS2hENnZ3Vitp?=
 =?utf-8?B?OFIrb3NoWEI5S1U2U2NGZTBzUjBZaW1wTjl4UGlHVjd2ZHVDSDk2eUVCUkEx?=
 =?utf-8?B?VlBXcmQyTHo1bWxLVWh6UDgzOUdRUmZWbCtKWWV3Y3pJdm9IbFZ1UU82NzJB?=
 =?utf-8?B?RlFpMDRoVDNDSmFqbXJJUk9aTlIzWWtpNmNDS1hmcldNNzkvQ1gzT1lrM2xX?=
 =?utf-8?B?Y01Cdy9CZUducjZjblNnTE5NZGM5Z250N2VZOHBDbmVxQUJka0tkSVR6ZzRR?=
 =?utf-8?B?Y1NadEpmaThvM2EyeUcrUVVXOVpISXExSnJSOEdkSmc5NVFkWDRFN0o1T01U?=
 =?utf-8?B?c3hOOVZhUjd4blYrKzYzZkFIcy9oZkR6OS9QVjYzVVowL3FDVU5oVStwWlcy?=
 =?utf-8?B?WmhwVUNyT0NwbVBpT3h0K0NLdnc0bUk3QTE0UXFpN2xWaEh0TUxzR1lPMG56?=
 =?utf-8?B?OUYxWGNvTXRud1BhSmo0UXhJdFJpc1Joa0hraVNQZno5UnB3TENzSE5vVzdO?=
 =?utf-8?B?SHNEVEhOQVFnSm9RWUNOcC9MejkwWmVaWmZNVHR1K1NhZmJDM2RvdXdVS3lp?=
 =?utf-8?B?blQ4bzNwUyt5ZVdSL0VrK3hFN1ltOHdMQmhFZDk1Qm5kUk0rdkUvSFdOSjhp?=
 =?utf-8?B?M2dNZFlzZjU1OGhrRlF3UWZQY3ozNDFzYlNrWERuaWpIem1HODFFR0x4NW1F?=
 =?utf-8?B?MWd3UzNwdi96ZDlVaEorQjJESWp2eS9zc09aa1lwVklnY08wdG5ST2VVUkp0?=
 =?utf-8?B?dTRNdGJ6R1IxODdzV1NiMUJKb3ZSUit0TGJzamN5UjZiTHNpK1BCN1hiSHBI?=
 =?utf-8?B?WEl3bk9wK1pTY3BwV2hDTXUzeE51cnF5QU1LMkpMN1N5d3pPbS9xM08vM21V?=
 =?utf-8?B?QUhJVDBXaTVUUmVmc1FPWEs3VVdXQ0hha3NKU0NJbTdsZkE1RGZtU1BvUzdx?=
 =?utf-8?B?RVZ2bkc2VkovbFAyblV5eHljRWJpL1d1eXl2RjAwNERTM2tQTmJORzdSWFhz?=
 =?utf-8?B?b0ZPZFA3aFBkdmdVQmxFSDNFZkR5b29VSDVXeVdINkZFNFJXbmh3MEtibGdL?=
 =?utf-8?B?SlJYQkJ4MDN3ZHdFU013d0pPQmRiZ1N5ZEVhcEg2NThIajZtVWZ0S1ZiczBG?=
 =?utf-8?B?R0piY05zUzA1NEdTclpzMjZGOUsvdVUvNnNKdWZ5L1FXUmp3ZmdlVVpReFox?=
 =?utf-8?B?cnpINnBGWXZwZGtXZ1FyMWVma2JQS2JHTGlHVHFzVEo1UFlIN1B0VndXaVA5?=
 =?utf-8?B?dzFqV3p3Qjc5bFVmc0lxaU5hay9SSWNTbG1lWkJUSG5rbWFBWFNuVEFDL0lZ?=
 =?utf-8?B?UTJ4UTl1Tk00c3J1eHNLOXZ0aWQxNGRhV2gzT0U5NUJCclhjME9FYkI1Qkg4?=
 =?utf-8?B?YkYrVy9IV2RJMi9aR1VaYU9pRGRYVlIxR0d2KzdrVXdvb2w3YUZQN2hiYSts?=
 =?utf-8?B?dTRLRVNTQ2N1OFJsRU4zT09ZUDhpTEtLV3NvTHFVcVJZWml0Ung3ZTAxMjFn?=
 =?utf-8?B?SjBBYVBMUExLZHFSNEtadVZ0RzRielVTNHVTakZ1UEx2YjI4ODNmcWhDWmpy?=
 =?utf-8?B?WElzUHhCWUpKNGtqUElQS1hmbXc1VXpnS3YvMFdNSUxmSnpucDdmdEpjaVcr?=
 =?utf-8?B?R0lwVGxQWE9JT0hLOVNwRlFYdUd3UG9TdkYxajdvZ0FJYlU4QitWMUN0QUEr?=
 =?utf-8?B?cTREb1oxSDZsbzVnaXlmRWxVRUxvekUzZGVnY3NTOGpUUmlzbkNlaTQ4Qm5Y?=
 =?utf-8?Q?0snUXmvpKPAKGUyJYlm3SDE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a91c27-ac47-40e8-1bbe-08d9d229e0fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 22:05:56.1598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVH2SaZeTK2L1HY9YRwjReL5Iq0YbTGfRZUj062Mb65qTrNG/gzmllPz9ntzzQNRo2QYu/h03f9Iy/QtgbQXRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
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

On 2022-01-07 4:40 p.m., Mario Limonciello wrote:
> Otherwise future commands may fail as well leading to downstream
> problems that look like they stemmed from a timeout the first time
> but really didn't.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I guess we used to do this but after we started adding the 
wait_for_response prior to sending the command this was ignored.

Should be fine.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> index 8c2b77eb9459..162ae7186124 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> @@ -119,6 +119,12 @@ int dcn31_smu_send_msg_with_param(
>   
>   	result = dcn31_smu_wait_for_response(clk_mgr, 10, 200000);
>   
> +	if (result == VBIOSSMC_Result_Failed) {
> +		ASSERT(0);
> +		REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Result_OK);
> +		return -1;
> +	}
> +
>   	if (IS_SMU_TIMEOUT(result)) {
>   		ASSERT(0);
>   		dm_helpers_smu_timeout(CTX, msg_id, param, 10 * 200000);

