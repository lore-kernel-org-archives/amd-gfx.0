Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8338C4727E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 10:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567D02074A
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 10:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uzF9Dq1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567D02074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C1B6E5C6;
	Wed, 30 Sep 2020 10:43:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7763C6E5C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 10:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgvRVjxdS4FcgDta4E5e3o9VxsMU5rVY/84y/Kc66ZA/coUIPRIjtCW0a3EUhJ/8+w3SK7KMuEso0F7P5hQkXzY0+eeRJtRoRPl1NXfV62no6eShsxrK1HoWdg5vh7BPnGxLk3qqYRC3FAbSKpHgOZOvO6mNxVTmH7VI8e2dLhLoB4I/GIhh987cIsNTT2HkL4cwq2VkcOc8Fl4uwBS2xir5ySL+TLLOyPNnMI584g4mG7XkUjCt/xWg05h3Jf1gAr2H+eX2MrmpYLpUFlRhyeiQqe9KU48p8NNq4e4I/C9F/VKQJMAtNvpuvnDF8DtC+t3bYOrLHJQdwVsVw500tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xYpLnnNG7qQpAIz/4cC65HqeEgJXD2sHnOIC9NUuRc=;
 b=W/R249rZNLYodd4139zEK7OhWhW1qNmhFMyZFVUSRPbW13jBTdj9ClrAbL9ECZw1PZaFA9LpjlPDtDeA72xhtxbofHA1I40ommqKt4cPtn5rQImeWSJPTHgWDiWU2zw4gJzFmqZd/FlywIs1jRVTXXiV8bOcFCQpUV+/YKW+eNRj6qIsqsdSkdxQe4o3Ct+nvbVKDTOmIQh2oxPoVBVlYVWz9WlmgWymIhFXf8Ufjiqb+dfOdU+tCLdd2aJl/gOL6JXAtBY8SYhL6H7Tv+Bhc8dm3WVvuLZw+MK2opDJK6bLNSMqSpog1uWN0t6l4bEdUuHcvVPIonBZ82qGtfNFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xYpLnnNG7qQpAIz/4cC65HqeEgJXD2sHnOIC9NUuRc=;
 b=uzF9Dq1OHyXlwMEURaHpJuKvqzr3bgzsYGmLzJEVkqSoVXiMs02k3stCXBZOv65b5KIY+/wjdUhUmmZewXubevQGLCQrVU9SJtm+mWc17WDl83aiS7x56JmQQkmeReoEBPZDdAOmvRxsd4bQJ5VK1o4Z9ReOr/BjVPowFM8lvnI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Wed, 30 Sep
 2020 10:42:59 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 10:42:59 +0000
Subject: Re: [PATCH] drm/amd/pm: setup APU dpm clock table in SMU HW
 initialization
To: amd-gfx@lists.freedesktop.org
References: <20200930040756.23559-1-evan.quan@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <73cf5a9e-ca34-0ed0-3a79-2cfb012890c9@amd.com>
Date: Wed, 30 Sep 2020 12:42:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200930040756.23559-1-evan.quan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR11CA0047.namprd11.prod.outlook.com
 (2603:10b6:404:4b::33) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.5.98] (165.204.84.11) by
 BN6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:404:4b::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34 via Frontend Transport; Wed, 30 Sep 2020 10:42:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0efe2f03-4075-4e25-99f0-08d8652d9933
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0188:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01883221A1E9C0897AC7B1088B330@DM5PR1201MB0188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9A79pYGSBIVFK01MyKJg0I1aN4kTa10uotA/2W0oPRLc1xReqikumavKvVDKtcnjIdmpaz0kRzwJYxOmDfd2875ks1q/1guksGOVY/3HBquigsG/sIn8QbxaRqmyBRF+7bol3RWFnAs8QTSBNDal0Nqp1j7qmm2LpMbkfNtwH8oJRbj5+KZcENRobADGjrdIYIBxHbqRZ266z8e3E0yjd3cYZU4P+cMj4s8HImLF5BODFqZiuax4dk+aSZtYdEUqAXLfCBhEwaWixugvDjntbw2PgskLC9HSXSVUWhL27QvF7F5JPX912U83JW3lYeDj40Wp10IsqtcNukwyt2tAo9DiIwjdWbBVwmz0oNEa8XjkrHdNJlQq0xtuO0NEnR9quzI1b0zxRyrpLS/W1p1MTgSFKQ910wgHFLpSYgiX5SOCHUw7BPG2BA/5vhSYJ3pE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(66946007)(16526019)(2906002)(83380400001)(2616005)(8676002)(8936002)(478600001)(36756003)(5660300002)(31686004)(6666004)(31696002)(316002)(16576012)(66476007)(66556008)(956004)(6916009)(6486002)(186003)(52116002)(53546011)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9OCSXwIvOGGzHTFWhUmQ3uPBLGaYQBqHZP2bWysgg+nQePKmQk5P7vkQleHNmqBu3tbNmHQxX4mU7AIAVvD0C6rWg4FtycEfcC90smULNGJ6BY3IV1BHtFSivp5eDan52+oQKrScnaYe+YG8h6Y2eFBIShycUCu1n4TRkhTTOAy9Vsc0X2iwr8c9U1ALohx37XhmczI6Q8rE0UJWTqfDj6f5zzTv9sVK6wlXqt8UcjEUEkE/PFB4wQqTDAE5RdB7a2i4krrJjkDoT0jcL+vNNVLcDi3RSRYSjFQdXEqMfQDZGykwj8pQLq4u7i21PrxmYDTPjbtBypClJOu6IANYoL9MIIsYoNoJFAryslQMhIxOZT0U+2oX601fE2hF9aQdIb/k4/FSWoGP7mT+mwMAog3DvhXPkGMuSCsdISlEKLouvf5PDK8OmNnS6AMGaPTDstE0POsrDBnE4NJolv6byK1W/r+rO/WcLyTLFwWeF1XbNvMtTIBNuxMz8AGZIKeQ7nPX8Xgg7HIqrWVwAB93dZ3FvXPh4vT/sM5vkrMC4MbLe9rkHWl6ikKUp4WrT+8e/VVklP4vHQ2xlFoQirajCiRK56sdWltPxjg+iPA30s7zTmnfeKE/qIelLASswm/GA2xZizWtH1hohoIDT2kdVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efe2f03-4075-4e25-99f0-08d8652d9933
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 10:42:59.3783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGh6dVnED8wQIpCqb18KVFzpfPnnHsWPiwGSoJQ7nSIn+MXwmuV+Kylg03TuFbyllt4V26MuwG4htFX+Gc5Lnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0188
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 9/30/20 6:07 AM, Evan Quan wrote:
> As the dpm clock table is needed during DC HW initialization.
> And that (DC HW initialization) comes before smu_late_init()
> where current APU dpm clock table setup is performed. So, NULL
> pointer dereference will be triggered. By moving APU dpm clock
> table setup to smu_hw_init(), this can be avoided.
>
> Change-Id: I2bb1f9ba26f9c8820c08241da62f7be64ab75840
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reported-by: Dirk Gouders <dirk@gouders.net>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f46cf9ea355e..8f6045def272 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -482,17 +482,6 @@ static int smu_late_init(void *handle)
>   		return ret;
>   	}
>   
> -	/*
> -	 * Set initialized values (get from vbios) to dpm tables context such as
> -	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> -	 * type of clks.
> -	 */
> -	ret = smu_set_default_dpm_table(smu);
> -	if (ret) {
> -		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
> -		return ret;
> -	}
> -
>   	ret = smu_populate_umd_state_clk(smu);
>   	if (ret) {
>   		dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
> @@ -1021,6 +1010,17 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>   		return ret;
>   	}
>   
> +	/*
> +	 * Set initialized values (get from vbios) to dpm tables context such as
> +	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> +	 * type of clks.
> +	 */
> +	ret = smu_set_default_dpm_table(smu);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
> +		return ret;
> +	}
> +
>   	ret = smu_notify_display_change(smu);
>   	if (ret)
>   		return ret;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
