Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5943EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 15:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C352410E964;
	Wed, 16 Feb 2022 15:55:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2C610E964
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 15:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTh5srwhm/G54CYkvfWPP8kq8g+U7O5wZQQA90s15UulfF8cXPT82NmgWdlDdIJCYrblzT/bVQ4rpNrrNbk4dJPjHfvBv5XJinW2NBvsadg4WIobX0vL8xcjniyDI+jWKF5jqqDA52l/8QSUyq9uvXLF3IBWBmjCyISeEW5su1PXZ/Aoj1GUb38HyoqXF2WUvvt8qWoOK+U8rIyHQaPRmnAepmshI5A2FUI1JTckdBj9pXglmABNBfkZk/IIYYkCKSLyoax2FXaT5BkKWU6spy7kpwFty5AthzvpU83uHDZYXlhKMiDx0G44hUUjlNjElEMPOQA5JSjVFVjdSoDb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33a8EfF9GnCfS3VI0yVl2wI1Rq6VcZ8CB3SoENgCREU=;
 b=FrzKJmcpuztLJNMq4VUd5lNg4jFS4cy4thLnulQ/BWEeYRUOHcxheyc6PhESCtbrDcPrKTg3BPzPcSJqknxGSI7RhEEC/iFOTKr2TZ94YB94RkZY5kX8Ny/+yt1zg6tLCNCy5xMqWCRiTYkK6LQjaevUuaQXnkVAvUrwCqCLwweOphN3JZQbqUliA/KICFZVWKlM0KcXD83cLHiWkuXeHnCh90lI83XD2UukTwosa+yOGOGBQUx3rbc3iPo4E0jEmKegMO0FZevaxLGOWLtMTrahAQzdD1VU+i5Vnc178t4pIrsLCdQN790QxEoZeXUz4hPTGvcIBHEGkXZUiWs4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33a8EfF9GnCfS3VI0yVl2wI1Rq6VcZ8CB3SoENgCREU=;
 b=fK6sBafARiDaFpCFWz6GjAyak0svHu9ccBu7OUmNRQKIO4zo1wllVfDOvkFirUtXzo1uAlERzMPMs4yrDGDDHoX/LC0hAdZkHQWhkR1GyF0w+k7dcBaLLgrJeuUfT2whu/rKYs2u5fp5UYvRX4wsFTvxvD5+IiNzoeXIfMXFLQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 CY4PR12MB1206.namprd12.prod.outlook.com (2603:10b6:903:3b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.17; Wed, 16 Feb 2022 15:55:39 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::7535:f1b6:a4ea:1527]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::7535:f1b6:a4ea:1527%7]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 15:55:39 +0000
Message-ID: <300736b3-eff0-487e-e149-8a3feefcb89d@amd.com>
Date: Wed, 16 Feb 2022 10:55:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 5/6] drm/amd/display: Add DCN316 resource and SMU clock
 manager
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220215214447.2234978-1-alexander.deucher@amd.com>
 <20220215214447.2234978-4-alexander.deucher@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20220215214447.2234978-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:610:e6::34) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c211c48c-1a4e-4fc9-f161-08d9f164c729
X-MS-TrafficTypeDiagnostic: CY4PR12MB1206:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB12068AB082F98B78F9F2990F82359@CY4PR12MB1206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2yzf+j27skuMnWpXwC8+cq9Kpr5UfRXQ8nHYprj53qwLy6Bkmo5qxpD2YEyoslloDSoeY6YMhEqli7+bbly6KskgSJKJ2D1mL41tQSytJ6aQJ4DzqI/zyTPujGPIgTu/PLmypAI7e6qQCvoweyxVVTFJoB1uI30NB9Kg7g4AbHazn56U/7hWyC25lCagoL6dCANBFdEQbpfuw0zf3jr/C0JKBFRlSgl5Fl3wlE9kCOPyIQ/SeBy6AywUxq+/k+4KSdtoS4ZIVKwy4P/TsWrEqLjYeIyLEuuxKMWG1i44E6dm7qSyMZHxZjEGc+hsxpZnveFdwOCb+NfIZqUSsugbpdG08FfV/cHUx4INOrA5ip42W04aypiWgrVa4GTNWut4ZLyyk18U0S0lI3D8MeKljonMuTuzPiT6ftnJohIbEju78r7KoLs7q/EDI6mlhvE4CoUZ5+JJF6O9EDmHsJsCEuePeAS57BQ1+fWzkYJen8NyPd0tA/Vw0QfK5xLXv3g9zZVgoA07Z62/YEeKY1/WabEt/JPuF5cvy8EMJ1rFT/kSqqWyo+Vy1LOlqTDJnSgXIUQiGN+kqn7Da6GTnc0CbfwOVcIe/Su3PirHMYOgWrK96viywq6LDOx8lqrxsQe3GG0trYn4xGRuXYYw6b5B3LnAEpWB+DobdM94VdrNZzKdT95c4z1acLQMFkxW5N3Y5WvHftSEIDgZnlUkpge2Fg9/i3W/+RhOXXc0TMUD5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4744005)(2616005)(6512007)(53546011)(6486002)(2906002)(26005)(508600001)(186003)(8676002)(36756003)(31696002)(66556008)(86362001)(8936002)(31686004)(4326008)(6506007)(5660300002)(66476007)(66946007)(6666004)(38100700002)(54906003)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXNQenBWZng3NnVGeXV5cEhXcHY0ZEt3VUZ6OUZjc2ZtMDNlT3JMWTJqM3Yz?=
 =?utf-8?B?OGI1RElRKzZkdUNyaHlHZmdOWDNuQXV6ODA4d1drak9yMTFtTkkxWWx2ZFU3?=
 =?utf-8?B?cGNHcnY2NldwNWJiYUNBQXRrYW95bld3b01TSzBwOWwyWWUybUxZS3ViSitk?=
 =?utf-8?B?NDh2UXJVRWd1VmNDVlZjNnRKRjBqbGlveFdPeTRUWXR4bVdUZzcrWEVpRUlm?=
 =?utf-8?B?YUVXMnp3Yy9VN0MzdjBxbFNRR0NORG55OEdydm13TnI0K1VTYXoxSVlQMEtm?=
 =?utf-8?B?TEVQQW1rVG1XcjFqU0Mya25JcFVJQWVlR0k2eWR4TDRJTFRtY2N6aDdMeVBB?=
 =?utf-8?B?Yzl4OHZ0K21mLzdnWmhiR2tDMStsOU5XU09VUnpVYmduRFFWZVpUaHFYd2NF?=
 =?utf-8?B?bStzVXpGVW96Uy9EemJlMlJ1dHFkVTdvTGNqa1RKODA4TndJbnk5V1hiYXQw?=
 =?utf-8?B?L2E1TVlWc29NZ1BYaWxaNGF3UzJzVGgyYkh3VmptQld5b0tXVWhwVWhVZzdY?=
 =?utf-8?B?SnNWRUhJMFFXU3NDSFJMQ0FocjgzYTlBL1F6RkloVWtwaEd5YmVJejZNQThN?=
 =?utf-8?B?NHB5bkFXbFMrWUR5U0FSNnR5UHp4bGhBaUh5WVFHTEovWmNyeFNRR0tiT2VY?=
 =?utf-8?B?VjRVc0dTU3FlTjZEUUdHaG9sVTVqa1d6VHVzSVVFS3N1ejVzU3pHMktkYW5K?=
 =?utf-8?B?QWhyb3lwbVI2RTNpVlYrZTVxeDVIUExjNjRzNXNIeTdvbGE3U1RveC80OFRE?=
 =?utf-8?B?VmRwQnBLKys2MnZSVzhRYUkrZW9IYXowMmgxZ3BDVkVDN1Y2SjNRQ3FnVTFW?=
 =?utf-8?B?Ky9Uekthb2c4WVA4R3pBUEpIQzBBbXF3ZndVUFZUSkFoNm1XUFY0Sk5CY2Fw?=
 =?utf-8?B?MHB4VkVwWmdyVHcvdGhEcUVxL3FnYUtMUFJpY01nMVJ2RC8xbFVSNHp0UzR2?=
 =?utf-8?B?d0pQaDJJM1o0R2VWUlh0a1pZSmowVWg0K25PYjV1T1lmb2E4UitXZVFIOVVS?=
 =?utf-8?B?a3pqWG5oazZzYjlQWnNVRUFhaEU4WDAxVEJSc0tNek5ZRHVucGxsSG1TNW4w?=
 =?utf-8?B?eHE3NFV3aHVndnpHK2pzMlVPVnZ5L1BlSTd6RUYzMTFQOEViUUhKUzlSMkVN?=
 =?utf-8?B?WDdhU0JtQ0dwV2JPWVNVbElPU0I3bkZFNzM4Z3ZVTk9VUGQ1Y1RzZlZKL0cz?=
 =?utf-8?B?QlJQSmVjK0tuOEd4NXBQUG1LNFJsU21BUGdkUitHZGtLQlc1SDZvLzQ5SmlD?=
 =?utf-8?B?V0lDM015RGVMUHU1ZzRqSjdldFlWWEZDMFlTN3lXZk5NUU5OVkJZRXhLWS9R?=
 =?utf-8?B?bjZwOFVIUU91NkNOWkRqUFEzclVpZWlJeStIMzhGM2I0TUpDUHFWbWJKYVIr?=
 =?utf-8?B?ZVJwOTFNM0djVFV2b043ZjIxS252cElCNHJ5VURMZXp6Y0F4aXQ5aFhkSzNo?=
 =?utf-8?B?TGZjYlR6OHMzcVkzU0FLU0tCbUppMmdtd2ZRRXlpVW5TcTBteEk5MURnczlD?=
 =?utf-8?B?ZHhvdVhHa0QwQTU5Sk51ZmU3cFpOQmhiWm0yc3RZU1ZaOXF1NlZaUkthSkZl?=
 =?utf-8?B?YW05Tm1OYVRITG1FbnMyQ1M5dHVtdG1RMUZleFdxY0wvTWc3T01tNks3QWVj?=
 =?utf-8?B?a2pvT1FSaFBvaHZ0WlF0RDFpekFFZ1VYdnhqeGVYOGJLWUFvcTdXbFZEc1Vh?=
 =?utf-8?B?emt6Qk1PNi9tUHVPUm81eDlXVXkxNkZVSk5IeVl2K0lNMU5FNnZoblJaZHNG?=
 =?utf-8?B?ejJCUnM5OUFIVlFYOFYwZXJTL3ZHdlAzaVV0MkhTN2ZLSk9pTGVHVmdzUC8w?=
 =?utf-8?B?OE1DZFZ1bUlldlZLanFDemtjSkFiM3pkemxuOXNXZCtseFc1bnplQWQ4VWNQ?=
 =?utf-8?B?K1B4a3cvdG1CS1crK1p5MUpwRXk0aXlSUXBtV2JxcEZCSVdvL05OUnVtVlRB?=
 =?utf-8?B?My9XdURmNWFTQ0ozTUR3VXVCY3VPdGxSbzRIdCt0OEdiTlpBZTdib0MrUjNK?=
 =?utf-8?B?akwwK3p4bTN3TUIxa2VLRjJNZCtZMkU5YjIxc0pMcGNldXAxRk4rblJ0R3gz?=
 =?utf-8?B?K1JqdE55RVVkSGk2NWhiTjhTQU85SE00OWg3anVnOU9SZTZUU3lDNzNadDY4?=
 =?utf-8?Q?DcZg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c211c48c-1a4e-4fc9-f161-08d9f164c729
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:55:39.1011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIUT96I4M4U6KRGdiZ9SXYkCfs5PcGoyegt0nmKvkquelQZRtuUHn5lxlOLndIHL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1206
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Hansen Dsouza <Hansen.Dsouza@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-02-15 16:44, Alex Deucher wrote:
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
> index c5ddade8b187..a1bf2128feba 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
> @@ -106,6 +106,7 @@ GPIO_DCN30 = hw_translate_dcn30.o hw_factory_dcn30.o
>   AMD_DAL_GPIO_DCN30 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn30/,$(GPIO_DCN30))
>   
>   AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN30)
> +

Looks like we can drop this newline. Otherwise,

Reviewed-by: Leo Li <sunpeng.li@amd.com>

>   endif
>   ###############################################################################
>   # Diagnostics on FPGA
> -- 2.34.1
