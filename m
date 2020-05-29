Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F25C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 13:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E12206A1
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 13:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B9qIOsvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E12206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400B26E8FE;
	Fri, 29 May 2020 13:56:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB036E8FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 13:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WECRdxSDci3hHWhzjWYaViTU4fnrlltMndPiII5MLMgFnYYxc6QHE8k/uZV6ZhM7HaoEnpRTVhWHctvIARohuIXgNRRS8NCZl1kDcIbTJwbceB1yww37aTo3Mg8QQXqetrsxFDrWSbJQlftYBrlj99SdmijpRpvbpHSA7vZYp5Rj5TKeZeJN4zAV/EbrIKn25SBsxHWLbzyqqcu9YBWpMJNOmLpvfvLKGBJSZwNeSWte38LpX5wY6822Y6BrE2byhR4TsswEjx2eYc2yMw2eGyXL/nDtJ6HxfnrIRWA2uJp1lxlN+xaTfWklG/r9oSyMUAAMg7ihZ01zo+uGhSYuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVT4XYlgrqbAA4/4hzRurNOEzGTyuj65N9soo7zQ/Ys=;
 b=Jx/bcZkfzfy73LWRJcLphYAdEzvEGI3FxdDp5gTLOU37hvo6cq8ruCEyQ1PsA4R7z1N0sbx3/aFH8GaHErZm+pDvu+OhQaM1rYCIQTJLmJZJk1MDcGkMux/q46knZJxtFi2hp0xMSI3PdcMFQ91TZKxEVYICqbc718/gSJzlEIYybpG9/K3iIIKNruXp3nScpfwN0I45e8ZWjoafgUKvcIaqnBzRfbTVyDjv3zhmmTKOie7gjlw6Sx9eE3pCKc4SaNr7shNCBWkXnO1j831PXobodlnKVdfpOU3V3umR2C3AiXTyprWN6K0s/KXfUHJdh1nXyY4ENRdBOccRhefI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVT4XYlgrqbAA4/4hzRurNOEzGTyuj65N9soo7zQ/Ys=;
 b=B9qIOsvzE7vyoUuXIj7K+PKkbV78lM/sJiWQo/5DqJuV3c0ck6/Y4LV7cFCTe3n0dt8hxLEb9faIKg8bwqnASt9mm8z0f6vXoA1wtc2MfVql9+xU+kIGVARgoRKFlkSvoQy5xdpRT1Iq5rnBbT6Ugy2nxB86MmGewvx2bQvpIDU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3574.namprd12.prod.outlook.com (2603:10b6:a03:ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 29 May
 2020 13:56:37 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.3021.030; Fri, 29 May 2020
 13:56:37 +0000
Subject: Re: [PATCH] drm/amdgpu/display: drop the reduction loop when setting
 the sync groups
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200528140613.282473-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <da249d2c-1102-ad4b-1acb-1a62242ec22c@amd.com>
Date: Fri, 29 May 2020 09:56:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200528140613.282473-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:208:23c::22) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.226.127] (165.204.11.250) by
 MN2PR18CA0017.namprd18.prod.outlook.com (2603:10b6:208:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend
 Transport; Fri, 29 May 2020 13:56:36 +0000
X-Originating-IP: [165.204.11.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b309ae9-9f15-4858-9049-08d803d81b00
X-MS-TrafficTypeDiagnostic: BYAPR12MB3574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3574F185B758537570E0F392EC8F0@BYAPR12MB3574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RlA2BR/RMLkLDbBMQF++pImIxOv7D/kvJ8H+WBEawKGSOI2lwo8zBcZnNChaWUzeEj6UqMCmaiOFiEoM5WC3XEGO+CHQzqdxHFAQmNqK3+HGGZH+vV5lieo4Je4RmExwcM7O3oshy2r+iROiUh9TjTI13tJLoO99N+FBiLeKaBIBNzNNeaNZaZ4WkTp1+mzvgLKGD4Dclnsu0GV/S61EzfToId2kONaL9gi+Ae0830/RUz11wIlWqW01LEfVMOhrNuVRdgk8l41HrTlnROi8hybKmxL3vK4J+MhvSHdIYafyBe2Eiga+lPJTH8dAWkIALE+lfC7QJzIzP1tO0NmqXh46Z3o7kZFtAv2yq+CcMjhmf2U7oUp1OLUwi3gjUsIOtCtd1Qr+zRT96TsmBI53W6KAhNXVn9Bt+Kd0QV60ag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(53546011)(66476007)(8676002)(4326008)(16526019)(31686004)(16576012)(2906002)(186003)(5660300002)(8936002)(66556008)(31696002)(66946007)(6486002)(26005)(86362001)(478600001)(6666004)(2616005)(956004)(52116002)(83380400001)(36756003)(316002)(966005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JL2uBEZnCaUQUBdPcqZo6fgVLSqJQkjJPdED+fE5RYwI4hCovPjtHK3j0/dFn6UQQtJ2Zw3uhl2uKLkxrvAFkunk+3oETVNBG27NVK4qPUKdJchRxjNNcDOWP9D3DAtw4JcIad4Kjgh5itGRDslMcnTx8Tm8LielzL72WBK/N8no3HN2gQEKGYctA/LXeSJ+vZOYeK5nySBO3BhAZMN5lT/o5H4kth//tkB/wMi+nQmJO83RPWWRM4sAqdkwiioxfF2LwQb5rGoEonYtieUIp5NYgJlvjuT6IxCuQgqGd4EY6YsLiJZUM1IAREoGl/PDO/KNX/VfmKHqEkDIbk8HgFFQq4U1699FdTj8qc1Lhycjccz6SYcMFX99FFogDtw4ZG3LGnQOxln32GfiwKwxovLs1x5SZfZeNLYruAHj9z19uTiijqawa4uogn6r8YsCxCILJtHf9EwCp2OnWydu994bePooKlpsPKI400h3kaA45E5amDWZRRIaOm5ejFE8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b309ae9-9f15-4858-9049-08d803d81b00
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 13:56:37.5405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/gA2f/03vD0WIOAwIkyaMqSpooATaOLF/8E6tNMrR6HPKIcXg+nP8ibf/19G0wxi9GKS0aATD7xcVIPvBMC5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3574
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

On 2020-05-28 10:06 a.m., Alex Deucher wrote:
> The logic for blanked is not the same as having a plane_state. Technically
> you can drive an OTG without anything connected in the front end and it'll
> just draw out the back color which is distinct from having the OTG be blanked.
> If we add planes or unblank the OTG later then we'll still want the
> synchronization.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
> Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
> Cc: nicholas.kazlauskas@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com> > ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 04c3d9f7e323..6279520f7873 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1040,14 +1040,6 @@ static void program_timing_sync(
>   				status->timing_sync_info.master = false;
>   
>   		}
> -		/* remove any other pipes with plane as they have already been synced */
> -		for (j = j + 1; j < group_size; j++) {
> -			if (pipe_set[j]->plane_state) {
> -				group_size--;
> -				pipe_set[j] = pipe_set[group_size];
> -				j--;
> -			}
> -		}


Looking at this again, I think I may understand the issue this was 
trying to work around.

If we try to force timing synchronization on displays that are currently 
active then this is going to force reset the vertical position, 
resulting in screen corruption.

So what this logic was attempting to do was ensure that timing 
synchronization only happens when committing two streams at a time 
without any image on the screen.

Maybe it'd be best to just blank these streams out first, but for now, 
let's actually go back to fixing this by applying the actual dpg/tg 
check that Wenjing suggests, something like:

    if (pool->opps[i]->funcs->dpg_is_blanked)
                 s.blank_enabled = 
pool->opps[i]->funcs->dpg_is_blanked(pool->opps[i]);
            else
                 s.blank_enabled = tg->funcs->is_blanked(tg);



The reason why we have this issue in the first place is because 
amdgpu_dm usually commits a dc_state with the planes already in it 
instead of committing them later, so plane_state not being NULL is 
typically true.

Regards,
Nicholas Kazlauskas

>   
>   		if (group_size > 1) {
>   			dc->hwss.enable_timing_synchronization(
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
