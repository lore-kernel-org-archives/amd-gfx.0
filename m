Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1DAC63777
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 17:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA65205CA
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 17:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qul80e27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA65205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5FF6E4E3;
	Tue, 24 Nov 2020 17:18:49 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700083.outbound.protection.outlook.com [40.107.70.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0226E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 17:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeTQn+/MZh++o0ARA8PuptZgiwbuJ6Nho0nQ8pP+bD0f/g10md6kSOMvyKVG0c3NoWOAW33OcCsVTxpXst3Z8nW567yPK6dU112/fQ3ENiyMitS7K3UMPz7fUW2QTymRUMz9Br5yJ3dkCIqM9Y4itUgLqk7ZmrBZWy8ZrNMrRIpFN/RzhoEfA8i92MyqfUof34Rj7AnvqyTlH/VirB52qDAIV6WTg/dt1QsC7+IcVmP/3Y6LP5asp2jg6pHFEFMz0fJhi+ryx1Oa+MSJl4syC6rixbmkJcsR87SlK20Eoljmsu5N2qqaUGfnHJk+ggRQfbHWLBvyInmWTlv0aj2x1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H22X7s4St9sj46KEIGcy9TJufLRau2VYgHV0mQeZbyE=;
 b=UpcmQhL4z7Ozn/eBy8VH7d1ItkUzIjNNgYcfCAEUe53WLpaZfm7QDDcYt4+xlwFouV9fGwMDvxj8XgYDAQpY3s592UD0z07xzUwleDrp18lC+oNEUK8g8lbxusl2iZfW/vYiPRObJNnkm+eOvVVLmnGlPtRo7maI+h9pGqUXwBYuAXCEW+KP1p5oVg+y1dN3XmGre7dC9gs80rVaQ555Y+k8Txfa/PsZnqislPhkz1VKi6mhRETgyNlynHLppxULOgDxlXOxQ//NjuLJasDRfR/OmU0dTsqgLVLUGuCxbo8T/Vt06GebGzdWbwo4XIGmUgFhMSmxvVmBtF3vN8q6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H22X7s4St9sj46KEIGcy9TJufLRau2VYgHV0mQeZbyE=;
 b=Qul80e27Q1VP5dE7itHn6Rs0k5+HDwwEhnYHLBD4UJgDJCgPWo/CH3Gjc5ERXN45oh5kol7PyLbR6DX2haWE8m5L4jXV8xhf5nEbxtkG9CjF3p2f2X2gt4P25ZN4Cl0VhBWN2S9K7ZvbPpGlYPJw5eTvBpKdXP7nWMoL8gu4AIc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1130.namprd12.prod.outlook.com (2603:10b6:3:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 17:18:46 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3611.021; Tue, 24 Nov 2020
 17:18:46 +0000
Subject: Re: [PATCH] drm/amdgpu/display: drop leftover function definition
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201124165256.1760556-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <3f539e0a-d095-b13a-6e2d-1c9ea5acf8da@amd.com>
Date: Tue, 24 Nov 2020 18:18:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201124165256.1760556-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:405:1::15) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.2.109] (165.204.84.11) by
 BN6PR10CA0005.namprd10.prod.outlook.com (2603:10b6:405:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 17:18:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87e8b062-4765-4966-b788-08d8909d003a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1130ED5A41878D8BDF055A128BFB0@DM5PR12MB1130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:56;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnMfqAy8669AjR1yFzRYNAcVJJavu8yZ/ncNGG7ZzbywM+/gTGLzIQEiJEqWRguYrFqnm2hW/wZCS8h4mJ9bjM2Sj9TkFfzusQ/D3xqpMZoMP5WjIBNF8jQNoRtzBwBJxhWlp5WAuq5SYGxKdBT3FqTPtHf5r95Ca1OYil8E7B9zJcU1V5JgN1nb4e7Dk64sIsF0SIlDhb7/zJR9obhtQeFlkdIOjoxp7+naA19yWmvLf5Ck8FNyHIPhGLpG71Yeug2VRBPYN55NT6FoSXb5fCY3jMcr8z+a6QQ/XYmNnUf3H7+c5wXgAzaDEPh5+bHsI02cKNWWshWcjqHe6jf9CpvQFw5HQoRV9DD5LJgb5Dm96sS116esOW1TReaFWEaT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(478600001)(66946007)(4744005)(186003)(26005)(52116002)(31696002)(36756003)(956004)(2616005)(4326008)(6486002)(16526019)(66556008)(8676002)(5660300002)(8936002)(31686004)(316002)(53546011)(83380400001)(6666004)(2906002)(66476007)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Ri9mZVZJZjR3eEIwYm9LMlNza2JZMzZiNXZkQVcxeWdxY0t4Zk1GTDVXSlBP?=
 =?utf-8?B?eE9lb1orZ2pqOEwzMkVENTIzZU5lbnNocWtPUTUwaTlKaFMweW9weHF3K2Vy?=
 =?utf-8?B?L2lqRFpiUVFwQ0xLOFVudTNySUU1dXZpOU44bVhISDBJUC9sN09ZUzZsRjMr?=
 =?utf-8?B?c0JsVnhWL3pGbnV2blF2eDBrYkVMN2RRUjUzbEovaGpnNWpGOVRJNmVhMFlY?=
 =?utf-8?B?MzBJZ0hubU0vNGQ1OER4eW52S1JGMnQrdURPUHBIaHU5cklnWmppMFZPdUo3?=
 =?utf-8?B?UkczYWM5eWxJZmRmTVhIUnlOclVuZnVzaTBBZDlYUU80bGhIcGZXaXllWmxU?=
 =?utf-8?B?cUdJblVqQUZGRkpaSVhvOVdnRE9YUFhhOHZEdkVjQ01wZkcxYThTVWE3UVVH?=
 =?utf-8?B?cG83ckt5ZHluMXlYaElHYmI2WFhPSlVkbDFRV3ZtL044bTI0aWVLM0FQOVhy?=
 =?utf-8?B?eG9MZEFZMTlXbFNGSnZDVEpIRXBRWndRQlNmTWtWL055RFp3TXExZm5LU1Yr?=
 =?utf-8?B?elB2eTNaamFneE9NalRPZE01cktQMlpYWEQza01UM2pFb2dPS2lEeGIrQW1Y?=
 =?utf-8?B?WGxQZDBMaXVzZ1hYQjBDaGNCMEV5TkdJWEkxbmw4bE1nOHJwb3NGckZyM2J2?=
 =?utf-8?B?Ti9ManZQL2JnY3BHYy91S29xcHFIOTltRk1YQ0ZQYWFpa09YOVh3dGh3QWpF?=
 =?utf-8?B?QmpOUWQ0L1ZtQURYTVVFbEtYbjN6VWp6cVA4NGdXRXRlcjBpRGVFd1l2c1FO?=
 =?utf-8?B?L0E5M2Qra2pFMUE0VU5BZ012d0FCbnRJUXkwRXJTYnE1SkdzOC9KLzBKSXFO?=
 =?utf-8?B?SDR3bCtMT2o0UTJDS3hNQzA4N0Fub1MxSlB0L1ZNUGJqS0ZsaFlTZXNCY2lG?=
 =?utf-8?B?Rk1TdXVDQnRVSTcvU2FYZ2MwZERtVkxUSGppOEpocnJjMnlzemY4eVYzc0ZO?=
 =?utf-8?B?eTV1ZVFVV2MxeXVQeW15R2ZOaFhoSE41MGViSEpYL2tsaEFqWHo3bVkxdUtJ?=
 =?utf-8?B?cEk1MnM5eDB3Ry8zV2gwdjJkei9UeWthbzFGMnYxVkZreVRMRVlESnhoS0NB?=
 =?utf-8?B?akh0S0NXVGlLYzJEQ0lvTTB3V3hjUVU5VWpMSDBYNVdhWFdsK3BtVHh4SUw0?=
 =?utf-8?B?WS9ranEvdWt2Zm1FOXlmZXZzZHQ2OTFwLzcwN05MS1JWSUtnOVJpYWxjTSsw?=
 =?utf-8?B?U2hJTlliZ3llbHZyd29LOGF3ekRkSnZzOVIrVFc4VUZWdW8vSEtJQ2lHN29o?=
 =?utf-8?B?dW55ZmxlSXl5RSs5bnpEM2lveFNIN0Nha0FidDRaSVp3OURZcml6a2VaSlFY?=
 =?utf-8?Q?xhqM3W+0sxIqSbgNT41SDkeKiDpr6Ox99G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e8b062-4765-4966-b788-08d8909d003a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 17:18:46.3686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwoK4IRocpga0s+XXKDzK8qmuLpCX1AKYbEirmetsK9T3risFgjjrbHvw3bAGgCE1EEuosv5qy0RXlOjqCgRig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

On 11/24/20 5:52 PM, Alex Deucher wrote:
> No longer exists.
>
> Fixes: fa7580010fde1b ("drm/amd/display: init soc bounding box for dcn3.01.")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index 124ae5253d4b..7e95bd1e9e53 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -1223,8 +1223,6 @@ static const struct resource_create_funcs res_create_maximus_funcs = {
>   	.create_hwseq = dcn301_hwseq_create,
>   };
>   
> -static void dcn301_pp_smu_destroy(struct pp_smu_funcs **pp_smu);
> -
>   static void dcn301_destruct(struct dcn301_resource_pool *pool)
>   {
>   	unsigned int i;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
