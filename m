Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD3CC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 18:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D032073B
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 18:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e3W7RWag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D032073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1256E878;
	Tue, 31 Mar 2020 18:03:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208116E886
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 18:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgmQvmVd+CF03h4viE+MTFDLn41Kke5l1GMwHWFomjqio4CCELdR8Ly4N7tO9DclibRPdXALBGms5Ci3DYf7WRpXYYqjVpCr/nSKDBiXWD+QDDzm6bdDJG50nR8dgqXwj5ChuQhSBfjIh9xszPmft06BaI3K9tY+/rYR1s7awL2IXewtBGVPk3bbZHn519/Dt/Dpv6yf91HnKU1GkdS6tOTXdueoXDpZ3KeRJnfIa6enKkBCR0xSZtUw7QX9Yr5hEM433uwWjEkariUuNXwxyjetCWum6ZkDZEvDaE5as9UpB1j2uR9Kcd9Ow8T7c/7oATo9jSi212QU4UHi19shFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCf9YoEpoqqHD0G1k74NpR2wFrhxFJMy7QqNTzPYmF8=;
 b=V1V3fEth3LuNbbfcdtrsycntJxxBcM4wdVZbLCoo8TPM+DphYXjmBdVYq4px4QrImBaR6ks90w7Jy2LjfM5l06qVTShVwcz8YLKU0idVaQ/Gg1A1DNQxzJ73CVIXLKUR21iYCYPICgHHLO/4ryq8WBzZ1GtJHWPZWNBXy3X5ol9SCmpxu861mc0L82zhlInsgyGmfuRyrxCF9ltIHN0Hx2aHkRSAasLp4F6qnxSGZvRDLIyK+k/CYfiEq6x/7Yio9TJPr4iULuuZ4GEzEPM0+zC1F7zPRUCXI/ukp/N38KgH6RPbjWuIBw/jWdKacTNisNgH3JZKQKspOPEcP5EVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCf9YoEpoqqHD0G1k74NpR2wFrhxFJMy7QqNTzPYmF8=;
 b=e3W7RWagsqRJLjSjz2h4XYLTk2TQCos4bV61N4v6WWoHtEjCScWTRCjRyDelBfCBwcKe7CIRU3otUNnbe1RFJK6Kl0yDaopdaJyiWlRpr2wNuIp75g3ujO4EMJk64c/DV4xEe5V8e1DX5rYNAjLnjl3h+dIVien/lnkgrZOk8dU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3223.namprd12.prod.outlook.com (2603:10b6:a03:138::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 18:03:48 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d%5]) with mapi id 15.20.2835.023; Tue, 31 Mar 2020
 18:03:48 +0000
Subject: Re: [PATCH] drm/amd/display: Guard calls to hdcp_ta and dtm_ta
To: Alex Deucher <alexdeucher@gmail.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
References: <20200330223616.28062-1-Bhawanpreet.Lakha@amd.com>
 <CADnq5_NM=K0FN7qPE166-11kLQbc9cdDKYE6RJH1BhfqooDsHw@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <d7b6c222-d3dd-47d8-1527-d56bcf7556ad@amd.com>
Date: Tue, 31 Mar 2020 14:03:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <CADnq5_NM=K0FN7qPE166-11kLQbc9cdDKYE6RJH1BhfqooDsHw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Tue, 31 Mar 2020 18:03:47 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a0f3c1b-35fc-4bd2-d75c-08d7d59ddc79
X-MS-TrafficTypeDiagnostic: BYAPR12MB3223:|BYAPR12MB3223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3223EB4189A5EE70591B6420ECC80@BYAPR12MB3223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(6486002)(54906003)(16576012)(36756003)(2906002)(110136005)(66946007)(66476007)(316002)(31686004)(966005)(66556008)(5660300002)(52116002)(4326008)(53546011)(30864003)(478600001)(31696002)(6666004)(6636002)(26005)(81156014)(8676002)(2616005)(8936002)(186003)(86362001)(16526019)(956004)(81166006)(579004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GjDeSKFhQ+Gk+xb+9Hsi6AayXMOQBezZp3ExgukfYbBP3FNxAXZt0o1vmx2FP8IMThwMcDTb3bEMFNVIY0ZR6EZLIDMJx6d4HV1dQxQWXTyTJzwQcuIbTmiMp1rZFvjYcl8zzwJKcmxWZqfgNGzdQenayUddfw79q3eogtW1V+gsCYd8DEUcUNGWcBCxhanmfu+LeClFxhf5DySsj8cbUn5zPuqAy4gmc43Mm2o9OyMTZ574R8Z+tOS3QK8klnjrHioM00Jk/uceHb8i+G5QLli8oHV8HMFfmmdk2C6IxrY2FGDGTTWWWIbeUStnpVTbbC8kMF33GL5xLMizcufjnFkXhiH7LUnkqCyZJPRfTvz2oMjRuBSnIk2dKRN85EZY9dMBM+O49tnybrjaqmIzYodqNMIzUo6EaV6hiMMHOChwiTL+OPu0/BNZTIY20zuS1MJbPf7sLzrzS5tRW0DAt5tR4NQSVIUY2825p7uW1A=
X-MS-Exchange-AntiSpam-MessageData: mL3vsr0yfKYHR+9SL3ouMyQIAMaLP8IRO44wmOHInD975MKgu4kWqRY663hfa6sn8r36My+pJYXNdedcGPed32UyByBQ88tdVQRpoSDdfBjKcpTBbdlF3Kky7+2j5F3LqrpOVEvlCiezcQ+iX8NW6Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0f3c1b-35fc-4bd2-d75c-08d7d59ddc79
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 18:03:48.6036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KN+DJe9m9SnIjX7eWFwVD2lVWv503vbVjjXT+9Yn9JYpVmHLRCWowDJhrsCGJJinCzGHMTYAPNnVkCf4ZHS8Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3223
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-31 1:37 p.m., Alex Deucher wrote:
> On Mon, Mar 30, 2020 at 6:36 PM Bhawanpreet Lakha
> <Bhawanpreet.Lakha@amd.com> wrote:
>>
>> [Why]
>> The buffer used when calling psp is a shared buffer. If we have multiple calls
>> at the same time we can overwrite the buffer.
>>
>> [How]
>> Add mutex to guard the shared buffer.
>>
>> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

One comment inline:

> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   2 +
>>   .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 420 +++++++++++-------
>>   3 files changed, 257 insertions(+), 167 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index dbaeffc4431e..9d587bc27663 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -888,6 +888,7 @@ static int psp_hdcp_load(struct psp_context *psp)
>>          if (!ret) {
>>                  psp->hdcp_context.hdcp_initialized = true;
>>                  psp->hdcp_context.session_id = cmd->resp.session_id;
>> +               mutex_init(&psp->hdcp_context.mutex);
>>          }
>>
>>          kfree(cmd);
>> @@ -1033,6 +1034,7 @@ static int psp_dtm_load(struct psp_context *psp)
>>          if (!ret) {
>>                  psp->dtm_context.dtm_initialized = true;
>>                  psp->dtm_context.session_id = cmd->resp.session_id;
>> +               mutex_init(&psp->dtm_context.mutex);
>>          }
>>
>>          kfree(cmd);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> index 297435c0c7c1..6a717fd5efc7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> @@ -161,6 +161,7 @@ struct psp_hdcp_context {
>>          struct amdgpu_bo        *hdcp_shared_bo;
>>          uint64_t                hdcp_shared_mc_addr;
>>          void                    *hdcp_shared_buf;
>> +       struct mutex            mutex;
>>   };
>>
>>   struct psp_dtm_context {
>> @@ -169,6 +170,7 @@ struct psp_dtm_context {
>>          struct amdgpu_bo        *dtm_shared_bo;
>>          uint64_t                dtm_shared_mc_addr;
>>          void                    *dtm_shared_buf;
>> +       struct mutex            mutex;
>>   };
>>
>>   #define MEM_TRAIN_SYSTEM_SIGNATURE             0x54534942
>> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
>> index c2929815c3ee..aa147e171557 100644
>> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
>> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
>> @@ -51,12 +51,15 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
>>          struct ta_dtm_shared_memory *dtm_cmd;
>>          struct mod_hdcp_display *display =
>>                          get_active_display_at_index(hdcp, index);
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>>          dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
>>
>>          if (!display || !is_display_added(display))
>>                  return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
>>
>> +       mutex_lock(&psp->dtm_context.mutex);
>> +
>>          memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
>>
>>          dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2;
>> @@ -66,14 +69,15 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
>>
>>          psp_dtm_invoke(psp, dtm_cmd->cmd_id);
>>
>> -       if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
>> +       if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
>> +       } else {
>> +               display->state = MOD_HDCP_DISPLAY_ACTIVE;
>> +               HDCP_TOP_REMOVE_DISPLAY_TRACE(hdcp, display->index);
>> +       }
>>
>> -       display->state = MOD_HDCP_DISPLAY_ACTIVE;
>> -       HDCP_TOP_REMOVE_DISPLAY_TRACE(hdcp, display->index);
>> -
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> -
>> +       mutex_unlock(&psp->dtm_context.mutex);
>> +       return status;
>>   }
>>   enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
>>                                                        uint8_t index)
>> @@ -83,6 +87,7 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
>>          struct mod_hdcp_display *display =
>>                          get_active_display_at_index(hdcp, index);
>>          struct mod_hdcp_link *link = &hdcp->connection.link;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>>          if (!psp->dtm_context.dtm_initialized) {
>>                  DRM_ERROR("Failed to add display topology, DTM TA is not initialized.");
>> @@ -94,6 +99,7 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
>>
>>          dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
>>
>> +       mutex_lock(&psp->dtm_context.mutex);
>>          memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
>>
>>          dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2;
>> @@ -113,13 +119,15 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
>>
>>          psp_dtm_invoke(psp, dtm_cmd->cmd_id);
>>
>> -       if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
>> -
>> -       display->state = MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
>> -       HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
>> +       if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
>> +       } else {
>> +               display->state = MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
>> +               HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
>> +       }
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->dtm_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
>> @@ -128,6 +136,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
>>          struct psp_context *psp = hdcp->config.psp.handle;
>>          struct mod_hdcp_display *display = get_first_added_display(hdcp);
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>>          if (!psp->hdcp_context.hdcp_initialized) {
>>                  DRM_ERROR("Failed to create hdcp session. HDCP TA is not initialized.");
>> @@ -135,6 +144,8 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
>>          }
>>
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>> +
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>>          hdcp_cmd->in_msg.hdcp1_create_session.display_handle = display->index;
>> @@ -144,16 +155,18 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
>>
>>          hdcp->auth.id = hdcp_cmd->out_msg.hdcp1_create_session.session_handle;
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAILURE;
>> -
>> -       hdcp->auth.msg.hdcp1.ainfo = hdcp_cmd->out_msg.hdcp1_create_session.ainfo_primary;
>> -       memcpy(hdcp->auth.msg.hdcp1.aksv, hdcp_cmd->out_msg.hdcp1_create_session.aksv_primary,
>> -               sizeof(hdcp->auth.msg.hdcp1.aksv));
>> -       memcpy(hdcp->auth.msg.hdcp1.an, hdcp_cmd->out_msg.hdcp1_create_session.an_primary,
>> -               sizeof(hdcp->auth.msg.hdcp1.an));
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAILURE;
>> +       } else {
>> +               hdcp->auth.msg.hdcp1.ainfo = hdcp_cmd->out_msg.hdcp1_create_session.ainfo_primary;
>> +               memcpy(hdcp->auth.msg.hdcp1.aksv, hdcp_cmd->out_msg.hdcp1_create_session.aksv_primary,
>> +                      sizeof(hdcp->auth.msg.hdcp1.aksv));
>> +               memcpy(hdcp->auth.msg.hdcp1.an, hdcp_cmd->out_msg.hdcp1_create_session.an_primary,
>> +                      sizeof(hdcp->auth.msg.hdcp1.an));
>> +       }
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp)
>> @@ -162,7 +175,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp)
>>          struct psp_context *psp = hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          uint8_t i = 0;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -171,27 +186,30 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FAILURE;
>> -
>> -       HDCP_TOP_HDCP1_DESTROY_SESSION_TRACE(hdcp);
>> -       for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
>> -               if (is_display_encryption_enabled(
>> -                               &hdcp->displays[i])) {
>> -                       hdcp->displays[i].state =
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FAILURE;
>> +       } else {
>> +               HDCP_TOP_HDCP1_DESTROY_SESSION_TRACE(hdcp);
>> +               for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
>> +                       if (is_display_encryption_enabled(&hdcp->displays[i])) {
>> +                               hdcp->displays[i].state =
>>                                          MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
>> -                       HDCP_HDCP1_DISABLED_TRACE(hdcp,
>> -                                       hdcp->displays[i].index);
>> -               }
>> +                               HDCP_HDCP1_DISABLED_TRACE(
>> +                                       hdcp, hdcp->displays[i].index);
>> +                       }
>> +       }
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(struct mod_hdcp *hdcp)
>>   {
>>          struct psp_context *psp = hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -206,10 +224,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;
>> -
>> -       if (hdcp_cmd->out_msg.hdcp1_first_part_authentication.authentication_status ==
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;
>> +       } else if (hdcp_cmd->out_msg.hdcp1_first_part_authentication.authentication_status ==
>>              TA_HDCP_AUTHENTICATION_STATUS__HDCP1_FIRST_PART_COMPLETE) {
>>                  /* needs second part of authentication */
>>                  hdcp->connection.is_repeater = 1;
>> @@ -219,12 +236,12 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(struct mod_hdcp *hdcp)
>>          } else if (hdcp_cmd->out_msg.hdcp1_first_part_authentication.authentication_status ==
>>                     TA_HDCP_AUTHENTICATION_STATUS__HDCP1_KSV_REVOKED) {
>>                  hdcp->connection.is_hdcp1_revoked = 1;
>> -               return MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED;
>> +               status = MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED;
>>          } else
>> -               return MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;
>> -
>> +               status = MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(struct mod_hdcp *hdcp)
>> @@ -232,7 +249,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(struct mod_hdcp *hdcp)
>>          struct psp_context *psp = hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct mod_hdcp_display *display = get_first_added_display(hdcp);
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -241,14 +260,15 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION;
>> -
>> -       if (!is_dp_mst_hdcp(hdcp)) {
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION;
>> +       } else if (!is_dp_mst_hdcp(hdcp)) {
>>                  display->state = MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
>>                  HDCP_HDCP1_ENABLED_TRACE(hdcp, display->index);
>>          }
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist_vp(struct mod_hdcp *hdcp)
>> @@ -257,6 +277,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist_vp(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -287,6 +308,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist_vp(struct mod_hdcp *hdcp)
>>                  status = MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE;
>>          }
>>
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>>          return status;
>>   }
>>
>> @@ -296,7 +318,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(struct mod_hdcp
>>          struct psp_context *psp = hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          int i = 0;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>
>>          for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
>> @@ -313,21 +337,26 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(struct mod_hdcp
>>
>>                  psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -               if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -                       return MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE;
>> +               if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +                       status = MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE;
>> +                       break;
>> +               }
>>
>>                  hdcp->displays[i].state = MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
>>                  HDCP_HDCP1_ENABLED_TRACE(hdcp, hdcp->displays[i].index);
>>          }
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_link_maintenance(struct mod_hdcp *hdcp)
>>   {
>>          struct psp_context *psp = hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> @@ -339,12 +368,12 @@ enum mod_hdcp_status mod_hdcp_hdcp1_link_maintenance(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILURE;
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS ||
>> +                       hdcp_cmd->out_msg.hdcp1_get_encryption_status.protection_level != 1)
>> +               status = MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILURE;
>>
>> -       return (hdcp_cmd->out_msg.hdcp1_get_encryption_status.protection_level == 1)
>> -                      ? MOD_HDCP_STATUS_SUCCESS
>> -                      : MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILURE;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_get_link_encryption_status(struct mod_hdcp *hdcp,
>> @@ -365,18 +394,22 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
>>          struct psp_context *psp = hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct mod_hdcp_display *display = get_first_added_display(hdcp);
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>> +
>>
>>          if (!psp->hdcp_context.hdcp_initialized) {
>>                  DRM_ERROR("Failed to create hdcp session, HDCP TA is not initialized");
>>                  return MOD_HDCP_STATUS_FAILURE;
>>          }
>>
>> -       hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>> -       memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> -
>>          if (!display)
>>                  return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>> +
>> +       hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>> +       memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> +
>>          hdcp_cmd->in_msg.hdcp2_create_session_v2.display_handle = display->index;
>>
>>          if (hdcp->connection.link.adjust.hdcp2.force_type == MOD_HDCP_FORCE_TYPE_0)
>> @@ -393,12 +426,14 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_CREATE_SESSION_FAILURE;
>>
>> -       hdcp->auth.id = hdcp_cmd->out_msg.hdcp2_create_session_v2.session_handle;
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> +               status = MOD_HDCP_STATUS_HDCP2_CREATE_SESSION_FAILURE;
>> +       else
>> +               hdcp->auth.id = hdcp_cmd->out_msg.hdcp2_create_session_v2.session_handle;
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *hdcp)
>> @@ -406,7 +441,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *hdcp)
>>          struct psp_context *psp = hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          uint8_t i = 0;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -415,20 +452,21 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FAILURE;
>> -
>> -       HDCP_TOP_HDCP2_DESTROY_SESSION_TRACE(hdcp);
>> -       for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
>> -               if (is_display_encryption_enabled(
>> -                               &hdcp->displays[i])) {
>> -                       hdcp->displays[i].state =
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FAILURE;
>> +       } else {
>> +               HDCP_TOP_HDCP2_DESTROY_SESSION_TRACE(hdcp);
>> +               for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
>> +                       if (is_display_encryption_enabled(&hdcp->displays[i])) {
>> +                               hdcp->displays[i].state =
>>                                          MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
>> -                       HDCP_HDCP2_DISABLED_TRACE(hdcp,
>> -                                       hdcp->displays[i].index);
>> -               }
>> +                               HDCP_HDCP2_DISABLED_TRACE(
>> +                                       hdcp, hdcp->displays[i].index);
>> +                       }
>> +       }
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_prepare_ake_init(struct mod_hdcp *hdcp)
>> @@ -437,7 +475,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_ake_init(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -452,12 +492,13 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_ake_init(struct mod_hdcp *hdcp)
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>>          if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_PREP_AKE_INIT_FAILURE;
>> -
>> -       memcpy(&hdcp->auth.msg.hdcp2.ake_init[0], &msg_out->prepare.transmitter_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.ake_init));
>> +               status = MOD_HDCP_STATUS_HDCP2_PREP_AKE_INIT_FAILURE;
>> +       else
>> +               memcpy(&hdcp->auth.msg.hdcp2.ake_init[0], &msg_out->prepare.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.ake_init));
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_ake_cert(struct mod_hdcp *hdcp)
>> @@ -466,7 +507,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_ake_cert(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -488,26 +531,32 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_ake_cert(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE;
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.ake_no_stored_km, &msg_out->prepare.transmitter_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.ake_no_stored_km));
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.ake_stored_km,
>> -              &msg_out->prepare.transmitter_message[sizeof(hdcp->auth.msg.hdcp2.ake_no_stored_km)],
>> -              sizeof(hdcp->auth.msg.hdcp2.ake_stored_km));
>> -
>> -       if (msg_out->process.msg1_status == TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS) {
>> -               hdcp->connection.is_km_stored = msg_out->process.is_km_stored ? 1 : 0;
>> -               hdcp->connection.is_repeater = msg_out->process.is_repeater ? 1 : 0;
>> -               return MOD_HDCP_STATUS_SUCCESS;
>> -       } else if (msg_out->process.msg1_status == TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {
>> -               hdcp->connection.is_hdcp2_revoked = 1;
>> -               return MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED;
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE;
>> +       } else {
>> +               memcpy(hdcp->auth.msg.hdcp2.ake_no_stored_km,
>> +                      &msg_out->prepare.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.ake_no_stored_km));
>> +
>> +               memcpy(hdcp->auth.msg.hdcp2.ake_stored_km,
>> +                      &msg_out->prepare.transmitter_message[sizeof(hdcp->auth.msg.hdcp2.ake_no_stored_km)],
>> +                      sizeof(hdcp->auth.msg.hdcp2.ake_stored_km));
>> +
>> +               if (msg_out->process.msg1_status ==
>> +                   TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS) {
>> +                       hdcp->connection.is_km_stored =
>> +                               msg_out->process.is_km_stored ? 1 : 0;
>> +                       hdcp->connection.is_repeater =
>> +                               msg_out->process.is_repeater ? 1 : 0;
>> +                       status = MOD_HDCP_STATUS_SUCCESS;
>> +               } else if (msg_out->process.msg1_status ==
>> +                          TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {
>> +                       hdcp->connection.is_hdcp2_revoked = 1;
>> +                       status = MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED;
>> +               }
>>          }
>> -
>> -       return MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_h_prime(struct mod_hdcp *hdcp)
>> @@ -516,7 +565,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_h_prime(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -543,16 +594,15 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_h_prime(struct mod_hdcp *hdcp)
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>>          if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE;
>> -
>> -       if (msg_out->process.msg1_status != TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE;
>> +               status = MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE;
>> +       else if (msg_out->process.msg1_status != TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
>> +               status = MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE;
>>          else if (!hdcp->connection.is_km_stored &&
>> -                msg_out->process.msg2_status != TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_PAIRING_INFO_FAILURE;
>> -
>> +                  msg_out->process.msg2_status != TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
>> +               status = MOD_HDCP_STATUS_HDCP2_VALIDATE_PAIRING_INFO_FAILURE;
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_prepare_lc_init(struct mod_hdcp *hdcp)
>> @@ -561,7 +611,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_lc_init(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -577,12 +629,13 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_lc_init(struct mod_hdcp *hdcp)
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>>          if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_PREP_LC_INIT_FAILURE;
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.lc_init, &msg_out->prepare.transmitter_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.lc_init));
>> +               status = MOD_HDCP_STATUS_HDCP2_PREP_LC_INIT_FAILURE;
>> +       else
>> +               memcpy(hdcp->auth.msg.hdcp2.lc_init, &msg_out->prepare.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.lc_init));
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_l_prime(struct mod_hdcp *hdcp)
>> @@ -591,7 +644,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_l_prime(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -610,13 +665,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_l_prime(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE;
>> -
>> -       if (msg_out->process.msg1_status != TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE;
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS ||
>> +                       msg_out->process.msg1_status != TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
>> +               status = MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE;
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_prepare_eks(struct mod_hdcp *hdcp)
>> @@ -625,7 +679,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_eks(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -642,20 +698,24 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_eks(struct mod_hdcp *hdcp)
>>          hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUTHENTICATION_MSG_V2;
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_PREP_EKS_FAILURE;
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.ske_eks, &msg_out->prepare.transmitter_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.ske_eks));
>> -       msg_out->prepare.msg1_desc.msg_size = sizeof(hdcp->auth.msg.hdcp2.ske_eks);
>> -
>> -       if (is_dp_hdcp(hdcp)) {
>> -               memcpy(hdcp->auth.msg.hdcp2.content_stream_type_dp,
>> -                      &msg_out->prepare.transmitter_message[sizeof(hdcp->auth.msg.hdcp2.ske_eks)],
>> -                      sizeof(hdcp->auth.msg.hdcp2.content_stream_type_dp));
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_HDCP2_PREP_EKS_FAILURE;
>> +       } else {
>> +               memcpy(hdcp->auth.msg.hdcp2.ske_eks,
>> +                      &msg_out->prepare.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.ske_eks));
>> +               msg_out->prepare.msg1_desc.msg_size =
>> +                       sizeof(hdcp->auth.msg.hdcp2.ske_eks);
>> +
>> +               if (is_dp_hdcp(hdcp)) {
>> +                       memcpy(hdcp->auth.msg.hdcp2.content_stream_type_dp,
>> +                              &msg_out->prepare.transmitter_message[sizeof(hdcp->auth.msg.hdcp2.ske_eks)],
>> +                              sizeof(hdcp->auth.msg.hdcp2.content_stream_type_dp));
>> +               }
>>          }
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(struct mod_hdcp *hdcp)
>> @@ -663,27 +723,30 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(struct mod_hdcp *hdcp)
>>          struct psp_context *psp = hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct mod_hdcp_display *display = get_first_added_display(hdcp);
>> -
>> -       hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>> -       memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>>          if (!display)
>>                  return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>> +
>> +       hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>> +       memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> +
>>          hdcp_cmd->in_msg.hdcp2_set_encryption.session_handle = hdcp->auth.id;
>>
>>          hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP2_SET_ENCRYPTION;
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_FAILURE;
>> -
>> -       if (!is_dp_mst_hdcp(hdcp)) {
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_FAILURE;
>> +       } else if (!is_dp_mst_hdcp(hdcp)) {
>>                  display->state = MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
>>                  HDCP_HDCP2_ENABLED_TRACE(hdcp, display->index);
>>          }
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id_list(struct mod_hdcp *hdcp)
>> @@ -692,6 +755,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id_list(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>> +
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> @@ -712,23 +778,26 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id_list(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE;
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.repeater_auth_ack, &msg_out->prepare.transmitter_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.repeater_auth_ack));
>> -
>> -       if (msg_out->process.msg1_status == TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS) {
>> -               hdcp->connection.is_km_stored = msg_out->process.is_km_stored ? 1 : 0;
>> -               hdcp->connection.is_repeater = msg_out->process.is_repeater ? 1 : 0;
>> -               return MOD_HDCP_STATUS_SUCCESS;
>> -       } else if (msg_out->process.msg1_status == TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {
>> -               hdcp->connection.is_hdcp2_revoked = 1;
>> -               return MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED;
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE;
>> +       } else {
>> +               memcpy(hdcp->auth.msg.hdcp2.repeater_auth_ack,
>> +                      &msg_out->prepare.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.repeater_auth_ack));
>> +
>> +               if (msg_out->process.msg1_status ==
>> +                   TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS) {
>> +                       hdcp->connection.is_km_stored = msg_out->process.is_km_stored ? 1 : 0;
>> +                       hdcp->connection.is_repeater = msg_out->process.is_repeater ? 1 : 0;
>> +                       status = MOD_HDCP_STATUS_SUCCESS;
>> +               } else if (msg_out->process.msg1_status ==
>> +                          TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {
>> +                       hdcp->connection.is_hdcp2_revoked = 1;
>> +                       status = MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED;
>> +               }
>>          }
>> -
>> -
>> -       return MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp *hdcp)
>> @@ -737,7 +806,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
>>          uint8_t i;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -763,8 +834,13 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
>>                  HDCP_HDCP2_ENABLED_TRACE(hdcp, hdcp->displays[i].index);
>>          }
>>
>> -       return (hdcp_cmd->hdcp_status == TA_HDCP_STATUS__SUCCESS) ? MOD_HDCP_STATUS_SUCCESS
>> -                                                                 : MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION;
>> +       if (hdcp_cmd->hdcp_status == TA_HDCP_STATUS__SUCCESS)
>> +               status = MOD_HDCP_STATUS_SUCCESS;
>> +       else
>> +               status = MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION;
>> +
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream_management(struct mod_hdcp *hdcp)
>> @@ -774,7 +850,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream_management(struct mod_hdcp *h
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -789,15 +867,17 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream_management(struct mod_hdcp *h
>>          hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUTHENTICATION_MSG_V2;
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MANAGEMENT_FAILURE;
>> -
>> -       hdcp->auth.msg.hdcp2.stream_manage_size = msg_out->prepare.msg1_desc.msg_size;
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.repeater_auth_stream_manage, &msg_out->prepare.transmitter_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.repeater_auth_stream_manage));
>> +       if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) {
>> +               status = MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MANAGEMENT_FAILURE;
>> +       } else {
>> +               hdcp->auth.msg.hdcp2.stream_manage_size = msg_out->prepare.msg1_desc.msg_size;
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +               memcpy(hdcp->auth.msg.hdcp2.repeater_auth_stream_manage,
>> +                      &msg_out->prepare.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.repeater_auth_stream_manage));
>> +       }
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(struct mod_hdcp *hdcp)
>> @@ -806,7 +886,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
>> +       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -825,10 +907,14 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(struct mod_hdcp *hdcp)
>>          hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUTHENTICATION_MSG_V2;
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       return (hdcp_cmd->hdcp_status == TA_HDCP_STATUS__SUCCESS) &&
>> -                              (msg_out->process.msg1_status == TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
>> -                      ? MOD_HDCP_STATUS_SUCCESS
>> -                      : MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_FAILURE;
>> +       if (hdcp_cmd->hdcp_status == TA_HDCP_STATUS__SUCCESS &&
>> +           msg_out->process.msg1_status == TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
>> +               status = MOD_HDCP_STATUS_SUCCESS;
>> +       else
>> +               status = MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_FAILURE;
>> +
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_get_link_encryption_status(struct mod_hdcp *hdcp,

Looks like you're missing a mutex in this function ^

mod_hdcp_hdcp2_get_link_encryption_status

Which touches hdcp_shared_buf.

Nicholas Kazlauskas

>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
