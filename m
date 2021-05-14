Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445B1C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 11:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0AFC6127A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 11:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AFC6127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792896E1AA;
	Fri, 14 May 2021 11:11:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED0476E1AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 11:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWaQpbLKikGoOBw8Vt655hmNg/o4FqH/WhvdPT5yAUM1xmZRsBJ0ctl9A+q/d1HyutADfBJRRZI1X1Mcf77Q0aHtENQPtv/zCzwDlYOMlOMJwLcLp8W4KN5Rt73PnwcchdcriKVKIAu7h0nSNGSET7ZdskxfweYgP+P0VGuKeUGf6bITWFp7uImtov96dIq6e1LVNINbFikkpQf++aL8WRG2Y+EMByeca9f8ipAHME6xYUbfVy71E5fOe/szRnqB0qFvtpPjI89BzWFJWxSIzTvXtcET16pmf02P6lVuvsS4wPWVKfaerFCKkIGvaFoGwoNGe9C4Di2J24ShQQqbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rLBPoHhyTA1hk9NsXIegxJ/zQ3umzIhpwt6aI0LJ5o=;
 b=jC2JbI84B9UCBLQie5dbCB1opaZd3KH2BY6w3tz3HgImfBnnvwYEI1WfIJWM+9MN1xXpJfTmRl+Y3dP7Yisp8kJeEOFKPXmjp+V/JnmgakGqfVito0GTKP1xcsnURe/Mgea/B25UADhg9l/tN1PkMLUlQypk+ZCEhpp3+9i5wWFu2P+h82fXlUExB0NPxQlt1ur063MTClVtAkhVLxXW3HLxAXJblR+lDWI1oYvRdffKhPvlxQVyTAJddzUuyAtY2PyH78fLQ1nLzm1F2rJte+a5eWZuRc/QlyMPED8GCvM9NywueNyWmcQEE1p0rxTSwh3r0g38/7ESbSaO7dOgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rLBPoHhyTA1hk9NsXIegxJ/zQ3umzIhpwt6aI0LJ5o=;
 b=r7WahdvpFCUYD9+kODsWD459F1YDUf65hCXNc9xM00F0GNHQr6EbgZ+aZspYV1n8hjP/ED+CTYEMOgHwLRrsOn8sNOuxk4Skb6iHKDyhrZMz1AdhMIhXsvIvp/YRDc0ikNfO3lALGsRz8mQIeZbYEoQU0WAlltbwgC8W+x0dq4A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0232.namprd12.prod.outlook.com (2603:10b6:910:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 11:05:57 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 11:05:57 +0000
Subject: Re: [PATCH] drm/amdgpu/nv: remove unused variable
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210513184139.502126-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <9f8dc54b-2416-6cfe-0fc6-94538f93462b@amd.com>
Date: Fri, 14 May 2021 13:05:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210513184139.502126-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0417.namprd03.prod.outlook.com
 (2603:10b6:408:111::32) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.37.106] (165.204.84.11) by
 BN9PR03CA0417.namprd03.prod.outlook.com (2603:10b6:408:111::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 11:05:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7539f924-e553-4fbe-fb67-08d916c83ff2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0232E15028D87000BC6496658B509@CY4PR1201MB0232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzX3/6an2Y4Z3BWP7KP62yH0qKm+imKSE+mFIR/QDFR6ld3VNl0Dl63hCOB1t2PGOr7AzfSNrUJIkGj7nPDGiFzKMGCyjU/o8LrNrJUcwQaR5Dp4j7NEtOFVOVt7bwC5UwCDdudsEy+YvUWxesqC6Ppu8PEofQzQIyY2UvhwNPgb59O2yWalg0b0Csnj+dYiDx4I0gfX6LH3XA7QAiYIMTpx9gz+0Au8QcCVbkMLAZ4u9P51+Sj+FenTuP203Nx02b9+NcNQWJTWkJ8sKQucwKYIZRPA5JMaUkyE+uKBfBclvEFF6EOU8X60WjYSPunE8LdoCVj9KtjR+JSqLkesHCzIeO2PpvozMtQTDwDErZKmXB6aH71O412B2d5GUYPglxAxqScKu8fDokOxp8rifBIvogIzXNZGvppJPYHS0Agl7U+BMw3vD8EtVif5JP48iM/gg+jxNEaKLe5B291ABCdsG+8JIScIhRIDXV/B7xKQPQB9sC6ladl8T33ojnd9kdHJxY1VBNdnrCotGxpKbmrm0fStPjWpQcGdSgWshpSIRQYLCbaSZyt50FBW+vvJZX9atZXwr6ym3PybjKQQHrnKqIEvy28cJ2bWyRtiFKwIJCR/ardCjOSHtj5w+0q0SWAyI2oNck8XnIDZcLZ1fFJV5jU/tPjuIRX5hqeEg5c67S1hk85Gh0RrxlNvXV3flZ4Vuub0qz/YLYOo9BthUu37fRFlHn9yi9imEc8dqcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(83380400001)(66476007)(6486002)(956004)(478600001)(31686004)(5660300002)(53546011)(26005)(66556008)(316002)(2906002)(8676002)(31696002)(4744005)(186003)(16576012)(52116002)(6666004)(4326008)(38350700002)(38100700002)(16526019)(66946007)(36756003)(8936002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QUU0U1BRNXFORVB1cUMxV2g5b2ZWV29jT3dqV2IvSk5KZmVweTdETXZKbzFr?=
 =?utf-8?B?YS9IUjhMUkVkSmpWWUlyWWt1ZUxpUDR4a1J2QXNDL2NhejE5TDFtR1M4cGVI?=
 =?utf-8?B?MWovb0MyRHlUcDBZUWdoaUtBWFV5eW5mbmp4NnpsTjRTWUQyeGtBTUJaeE1U?=
 =?utf-8?B?eEhQbUNWZ1habzV4Z2ErL2FwcVE2U1FOazZMT1BiK1p6Y0FNdUtQWE12c1Ev?=
 =?utf-8?B?dHoxV3JVTkxTNWx6VzZxRXhLTU9NWnRqR1l0ZHpoUnNXQ29oYks2NTFXSy90?=
 =?utf-8?B?MXN3RXhNbHZjZTFvam9obk0wRE1la2NKRk82aEd1Qy9JT1pTYWIyQzhFMzZO?=
 =?utf-8?B?bVBKcTVQeERGUUhMWlpJVWJaaDRDTE44YlVXUVRsSmNKV2tiMDc0Q3RYdGVK?=
 =?utf-8?B?RG5JaXMzaENNWWlVNWt2cktpdjNFUFd2aWFUVU5FcmJPVXNMOUVKNHkxRFcx?=
 =?utf-8?B?YzN5U3lKUE9XVGlDV2hHanVuL2NaYitxQ3RBRHhMMktVb3V1VWdjbzlQY3pj?=
 =?utf-8?B?ei81K0RSL1I2bVBnS09MenFoSDZBelVibUVDNUthOG9lSE5vRERybkRQbEhn?=
 =?utf-8?B?NDVjVzlmMTZnUXI4b0FXYkQ3bXcvcWlTQ2Zqa2NjYUI2dWdKOXptM25pN1Fv?=
 =?utf-8?B?ek5xaDQwSGtqbHpyNHIyV1dNL2J3ZHVSUmNuOXlMdEpybmJkQ3lJSXJqQ1Ey?=
 =?utf-8?B?YWdROTdac2hRME81aFRMVkI0SnowVXZBNmxHQUlKNUp2QS84T1J6dnhBY2pX?=
 =?utf-8?B?YXkyQVQyWW41dzFDT0U2eVZheS9IUjk4VWpIcjRwOERMdDNxU25qV0o3QWEv?=
 =?utf-8?B?VHg2SStiZlN2VUJ4cUJUTndrbklESWVZVTVTR3Z6V25Db2kveDV0VFVWeG1p?=
 =?utf-8?B?UVB3RUN4SGV1ZjMzdmQzYmtacEpsRHNNR0JpMU1uWTMxRTFteFY1NFB2SDFv?=
 =?utf-8?B?Rm9jK1VIWEw2T0djNHRyV3BzTjFGR3orZnZwOWI0c0dVem15WjJuVE1idzVR?=
 =?utf-8?B?RjA5akk3MVA4WW1tM3MvalpTZlJFVXZjWGRXREdMUGMrSEhBVzRBc3RlQ2dj?=
 =?utf-8?B?eHFHKzh0Vlc5Ukh2WWhnZ2M4eERWenBkVTFGbTlxNjBHUjJ1ZUhOY1pDekJy?=
 =?utf-8?B?aHZTOWk0VUZzYWpHem54b3N2MXFXZHZxSEJrSjV3ZUtyang4WHNhdERoY0h1?=
 =?utf-8?B?YmRQdzkydHdTbUNNMU56dmpJY016MTZ6Z0dGZDFFK0N6SHpiSXJQSlMwZVMv?=
 =?utf-8?B?TUcvWm1RTi90NGF4RjdYVDZvQXBlamRKTVYwUGs5Q0o0RUhydU1kSHlESWZt?=
 =?utf-8?B?ankzeHorNTNVOGprMkdXYURxYTFzNGtpRmpvL25SOGJUWFZVcnh6THMwUE4r?=
 =?utf-8?B?d2hUUUE2Yms0N2ZGcFVUTlFpWW5qenFVdzg4ZnlkcGVIYjIrN2Z0UExjUmlQ?=
 =?utf-8?B?eGVaR1NVQUVxVjdPNER6TkQ3a0xEUFY4VmZhclJsYVhnaTdrOEZDbjBmOHNi?=
 =?utf-8?B?ejRVUS9XL1MxMndoMXluMFJUL3RWM3BZS3ZaY3FtR1JRbnhMeUEwVnl5NGFG?=
 =?utf-8?B?SUxPeWxaQUNSZXJXNVpoYW1mUVVYYWc0ZlI3RDBZWUJ0a2l3ZTlDM3N0elNl?=
 =?utf-8?B?ZmVwSGJ3VndlM0ZkbHBHeFBXejJxM05FMXYvRHZWMGhWUnpmV1NMdVEvWXY4?=
 =?utf-8?B?MEhlWS9EMGF6NlZ2bU1MZWMwZVFXQ29HUUQrclM3d0RTWVBEb2FaVzJvbmgy?=
 =?utf-8?Q?p0kir/wQsYc6OM+vyvM8oMus3BuSeTr8l8Wsouy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7539f924-e553-4fbe-fb67-08d916c83ff2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 11:05:57.5863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuKP0LYMblVOV+1MLa5i870TsihgbXRB9H+h+sY3FYQcI9fdge7Wli6ciQFDpwmKqSzPafMQ2CFhQ2OThOnBtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0232
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
Cc: Bokun Zhang <bokun.zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

On 5/13/21 8:41 PM, Alex Deucher wrote:
> Remove it.
>
> Fixes: b8d598968950 ("drm/amdgpu: Complete multimedia bandwidth interface")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Bokun Zhang <bokun.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 9f74060207a4..32c34470404c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1276,7 +1276,6 @@ static int nv_common_early_init(void *handle)
>   static int nv_common_late_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	uint32_t i;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		xgpu_nv_mailbox_get_irq(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
