Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF5BC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 18:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E03212CC
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 18:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OV2XqlJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E03212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDD289CAC;
	Tue, 31 Mar 2020 18:08:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770071.outbound.protection.outlook.com [40.107.77.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1882E89CAC
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 18:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp4y/p4y5H8zDrcWbU/bAl+E/4geWT7nwqDvsK7LhCsPovfCtuJg5i8pvwYD7fjwwbgfd5hDCATiT2EZDcdX4YN7IUH24RDgiAhovOA7ZervBFbMB0F6Us55NqDQX/0QkF/UG/xJ69bZ0HBQT9dgb5MyyjnmUbNYyeQTtimk6tuH25VzhK8auN5UU4IYTqDymCKabZ+8eiHBbTwgJIxlvMhTNmJ3/jSUJ3c4eQeJvfQlwBPUKkQRqN+zYakHLIdOJN4/XINzYkx0vbsWIWg58L0f9LE3NzBNFSeRAkwK4Z2pHzGixYVhsYyE2EmAOr0CHkUxtMi6knDYRRoHlrH0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5+Z6FDfCJ1cCJDVuoO5Ow1ssU+yjzxjLcFuGCMe43k=;
 b=iUl42StdyZqkeD+0tCYus+5su1XywEQq1lH+sZ7C10LmGSFXn1N8642sFKqSjW83CCswEiVJSBhPCGRepMR6zejaAJDAgq9YRomyF0cq8yBsVI5z2eGO7JCM6FmQcwNJbhWqhQTv8RmZCL+93YuiuTChx2IoUpsupkv2U+8wYnfk5MDWQMc8dfKClAH7li7s3Ma/3HNrTFYEz7ZV7EbsZgzaNigtTOvSaHWdeyzukJ+BcJNXVN1suv8wb/oKuoSec1l5ifI4yNSIxZRX6ETJGsIR2iQ/UnEmPzzuH9nY3ufC0ghCovlFOspSFN7tMZrW5CT6UVThNpwkq/c4+cvthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5+Z6FDfCJ1cCJDVuoO5Ow1ssU+yjzxjLcFuGCMe43k=;
 b=OV2XqlJTgbmi7fKakHs2jjzybeOouCCYncCyJr8VYkRAMV9NuVs9s+kUBAtA16rGwNYcAn2Tv8H2NVAhRw++BxzUGW+w2XO2sJlLHkNQgjB/ugOHFtxOyiyQQlPGofQI/DGagpOwAqG11vyV5TTTdV5hmZj6TyyGYO9v8MYvJDM=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Tue, 31 Mar
 2020 18:08:32 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::ad6a:482:305a:537f]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::ad6a:482:305a:537f%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 18:08:32 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Guard calls to hdcp_ta and dtm_ta
Thread-Topic: [PATCH] drm/amd/display: Guard calls to hdcp_ta and dtm_ta
Thread-Index: AQHWBuOkJim/uVmkHk6EzZsbuDAfJ6hi+F8AgAAHQQCAAADl9w==
Date: Tue, 31 Mar 2020 18:08:31 +0000
Message-ID: <MW3PR12MB45542A063E3FCF2E79A68B6EF9C80@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20200330223616.28062-1-Bhawanpreet.Lakha@amd.com>
 <CADnq5_NM=K0FN7qPE166-11kLQbc9cdDKYE6RJH1BhfqooDsHw@mail.gmail.com>,
 <d7b6c222-d3dd-47d8-1527-d56bcf7556ad@amd.com>
In-Reply-To: <d7b6c222-d3dd-47d8-1527-d56bcf7556ad@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-31T18:08:32.953Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bhawanpreet.Lakha@amd.com; 
x-originating-ip: [99.252.8.165]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0e027cd-bd35-48ad-4d27-08d7d59e85bb
x-ms-traffictypediagnostic: MW3PR12MB4346:|MW3PR12MB4346:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB43461A6E94A097F3DBB90303F9C80@MW3PR12MB4346.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(6506007)(5660300002)(53546011)(76116006)(9686003)(8936002)(8676002)(26005)(186003)(54906003)(55016002)(19627405001)(110136005)(81156014)(81166006)(7696005)(316002)(33656002)(86362001)(2906002)(4326008)(52536014)(64756008)(66556008)(66446008)(66946007)(30864003)(966005)(478600001)(71200400001)(66476007)(559001)(579004);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j8KBTk8BdS18vLV/QT62WIFOfFPEWNLFJ6FiGafm/c47uNxmTJOXgvK70/aw1QNF0ASAzM6cagtCahvC8FLOvyft7DVCLhUhqUX0tjM/fT/CrUYlrxmWAqy943qFHmIMw1Z83xhqemxAqmJfFNhiool/rbVaMinDeAObbeuKQxV8lXPAoOfGTJWQUKkXfeMoEi+kMYbRKjrnZeK98Cey+/aOM4hOnsBNafEO82MZ2YRV0/fSRv/qjAI5SWJCUa3ZYoma4yLW9CehpHsplLYUrcn8C/0cwxmWfMfDWB34enTbCWRx1Pw6OKtd2FMRxEZSF7GI1GO/LJRaJ7Jr4GwSeyg47dsrzveoNJvXg1rc/72Lgda3uXskY2d5AnZ6pKllqgbL32MszFI0lPuD0ba1hm/ELHPVEXTlL0hldEMKHtlepr46aFjfUAvU4Cuu0ur8+5zbpLJj3P5AT5oaTSdW14Mq1aStw69BlnsYOtwzXo8=
x-ms-exchange-antispam-messagedata: mADxg/ft+GMBg5lUtlpXgsTqGkQJxBtaDRbebhX4F1dd9ebvYOKmwB75QpH+g1vIRFTGXuYt41u5ESPC5GrHNheISsWy/YtfIEDY5MXuEX/P45gDRWUsqoyVIj/vLjwopvN8qFiFevVYl523yBqrQg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e027cd-bd35-48ad-4d27-08d7d59e85bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 18:08:31.8899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjhgKQtTq181DoM0a8lF4WANUgxfDrUp6X/nOWjTq4FyXfeR7w4LI0FrIZESLiAp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0809383404=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0809383404==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB45542A063E3FCF2E79A68B6EF9C80MW3PR12MB4554namp_"

--_000_MW3PR12MB45542A063E3FCF2E79A68B6EF9C80MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

mod_hdcp_hdcp2_get_link_encryption_status() isn't being used, should probab=
ly remove it in a followup patch
________________________________
From: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Sent: March 31, 2020 2:03 PM
To: Alex Deucher <alexdeucher@gmail.com>; Lakha, Bhawanpreet <Bhawanpreet.L=
akha@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx list <amd-gfx@l=
ists.freedesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amd/display: Guard calls to hdcp_ta and dtm_ta

On 2020-03-31 1:37 p.m., Alex Deucher wrote:
> On Mon, Mar 30, 2020 at 6:36 PM Bhawanpreet Lakha
> <Bhawanpreet.Lakha@amd.com> wrote:
>>
>> [Why]
>> The buffer used when calling psp is a shared buffer. If we have multiple=
 calls
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
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp.c
>> index dbaeffc4431e..9d587bc27663 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -888,6 +888,7 @@ static int psp_hdcp_load(struct psp_context *psp)
>>          if (!ret) {
>>                  psp->hdcp_context.hdcp_initialized =3D true;
>>                  psp->hdcp_context.session_id =3D cmd->resp.session_id;
>> +               mutex_init(&psp->hdcp_context.mutex);
>>          }
>>
>>          kfree(cmd);
>> @@ -1033,6 +1034,7 @@ static int psp_dtm_load(struct psp_context *psp)
>>          if (!ret) {
>>                  psp->dtm_context.dtm_initialized =3D true;
>>                  psp->dtm_context.session_id =3D cmd->resp.session_id;
>> +               mutex_init(&psp->dtm_context.mutex);
>>          }
>>
>>          kfree(cmd);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp.h
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
>> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drive=
rs/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
>> index c2929815c3ee..aa147e171557 100644
>> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
>> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
>> @@ -51,12 +51,15 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_to=
pology(
>>          struct ta_dtm_shared_memory *dtm_cmd;
>>          struct mod_hdcp_display *display =3D
>>                          get_active_display_at_index(hdcp, index);
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>>          dtm_cmd =3D (struct ta_dtm_shared_memory *)psp->dtm_context.dtm=
_shared_buf;
>>
>>          if (!display || !is_display_added(display))
>>                  return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
>>
>> +       mutex_lock(&psp->dtm_context.mutex);
>> +
>>          memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
>>
>>          dtm_cmd->cmd_id =3D TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2;
>> @@ -66,14 +69,15 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_to=
pology(
>>
>>          psp_dtm_invoke(psp, dtm_cmd->cmd_id);
>>
>> -       if (dtm_cmd->dtm_status !=3D TA_DTM_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
>> +       if (dtm_cmd->dtm_status !=3D TA_DTM_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
>> +       } else {
>> +               display->state =3D MOD_HDCP_DISPLAY_ACTIVE;
>> +               HDCP_TOP_REMOVE_DISPLAY_TRACE(hdcp, display->index);
>> +       }
>>
>> -       display->state =3D MOD_HDCP_DISPLAY_ACTIVE;
>> -       HDCP_TOP_REMOVE_DISPLAY_TRACE(hdcp, display->index);
>> -
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> -
>> +       mutex_unlock(&psp->dtm_context.mutex);
>> +       return status;
>>   }
>>   enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp =
*hdcp,
>>                                                        uint8_t index)
>> @@ -83,6 +87,7 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(=
struct mod_hdcp *hdcp,
>>          struct mod_hdcp_display *display =3D
>>                          get_active_display_at_index(hdcp, index);
>>          struct mod_hdcp_link *link =3D &hdcp->connection.link;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>>          if (!psp->dtm_context.dtm_initialized) {
>>                  DRM_ERROR("Failed to add display topology, DTM TA is no=
t initialized.");
>> @@ -94,6 +99,7 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(=
struct mod_hdcp *hdcp,
>>
>>          dtm_cmd =3D (struct ta_dtm_shared_memory *)psp->dtm_context.dtm=
_shared_buf;
>>
>> +       mutex_lock(&psp->dtm_context.mutex);
>>          memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
>>
>>          dtm_cmd->cmd_id =3D TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2;
>> @@ -113,13 +119,15 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topol=
ogy(struct mod_hdcp *hdcp,
>>
>>          psp_dtm_invoke(psp, dtm_cmd->cmd_id);
>>
>> -       if (dtm_cmd->dtm_status !=3D TA_DTM_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
>> -
>> -       display->state =3D MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
>> -       HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
>> +       if (dtm_cmd->dtm_status !=3D TA_DTM_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
>> +       } else {
>> +               display->state =3D MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
>> +               HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
>> +       }
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->dtm_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hd=
cp)
>> @@ -128,6 +136,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(s=
truct mod_hdcp *hdcp)
>>          struct psp_context *psp =3D hdcp->config.psp.handle;
>>          struct mod_hdcp_display *display =3D get_first_added_display(hd=
cp);
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>>          if (!psp->hdcp_context.hdcp_initialized) {
>>                  DRM_ERROR("Failed to create hdcp session. HDCP TA is no=
t initialized.");
>> @@ -135,6 +144,8 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(s=
truct mod_hdcp *hdcp)
>>          }
>>
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>> +
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>>          hdcp_cmd->in_msg.hdcp1_create_session.display_handle =3D displa=
y->index;
>> @@ -144,16 +155,18 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session=
(struct mod_hdcp *hdcp)
>>
>>          hdcp->auth.id =3D hdcp_cmd->out_msg.hdcp1_create_session.sessio=
n_handle;
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAILURE;
>> -
>> -       hdcp->auth.msg.hdcp1.ainfo =3D hdcp_cmd->out_msg.hdcp1_create_se=
ssion.ainfo_primary;
>> -       memcpy(hdcp->auth.msg.hdcp1.aksv, hdcp_cmd->out_msg.hdcp1_create=
_session.aksv_primary,
>> -               sizeof(hdcp->auth.msg.hdcp1.aksv));
>> -       memcpy(hdcp->auth.msg.hdcp1.an, hdcp_cmd->out_msg.hdcp1_create_s=
ession.an_primary,
>> -               sizeof(hdcp->auth.msg.hdcp1.an));
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAILURE;
>> +       } else {
>> +               hdcp->auth.msg.hdcp1.ainfo =3D hdcp_cmd->out_msg.hdcp1_c=
reate_session.ainfo_primary;
>> +               memcpy(hdcp->auth.msg.hdcp1.aksv, hdcp_cmd->out_msg.hdcp=
1_create_session.aksv_primary,
>> +                      sizeof(hdcp->auth.msg.hdcp1.aksv));
>> +               memcpy(hdcp->auth.msg.hdcp1.an, hdcp_cmd->out_msg.hdcp1_=
create_session.an_primary,
>> +                      sizeof(hdcp->auth.msg.hdcp1.an));
>> +       }
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *h=
dcp)
>> @@ -162,7 +175,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(=
struct mod_hdcp *hdcp)
>>          struct psp_context *psp =3D hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          uint8_t i =3D 0;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -171,27 +186,30 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destroy_sessio=
n(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FAILURE;
>> -
>> -       HDCP_TOP_HDCP1_DESTROY_SESSION_TRACE(hdcp);
>> -       for (i =3D 0; i < MAX_NUM_OF_DISPLAYS; i++)
>> -               if (is_display_encryption_enabled(
>> -                               &hdcp->displays[i])) {
>> -                       hdcp->displays[i].state =3D
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FAILURE=
;
>> +       } else {
>> +               HDCP_TOP_HDCP1_DESTROY_SESSION_TRACE(hdcp);
>> +               for (i =3D 0; i < MAX_NUM_OF_DISPLAYS; i++)
>> +                       if (is_display_encryption_enabled(&hdcp->display=
s[i])) {
>> +                               hdcp->displays[i].state =3D
>>                                          MOD_HDCP_DISPLAY_ACTIVE_AND_ADD=
ED;
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
>>          struct psp_context *psp =3D hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -206,10 +224,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(str=
uct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;
>> -
>> -       if (hdcp_cmd->out_msg.hdcp1_first_part_authentication.authentica=
tion_status =3D=3D
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;
>> +       } else if (hdcp_cmd->out_msg.hdcp1_first_part_authentication.aut=
hentication_status =3D=3D
>>              TA_HDCP_AUTHENTICATION_STATUS__HDCP1_FIRST_PART_COMPLETE) {
>>                  /* needs second part of authentication */
>>                  hdcp->connection.is_repeater =3D 1;
>> @@ -219,12 +236,12 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(st=
ruct mod_hdcp *hdcp)
>>          } else if (hdcp_cmd->out_msg.hdcp1_first_part_authentication.au=
thentication_status =3D=3D
>>                     TA_HDCP_AUTHENTICATION_STATUS__HDCP1_KSV_REVOKED) {
>>                  hdcp->connection.is_hdcp1_revoked =3D 1;
>> -               return MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED;
>> +               status =3D MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED;
>>          } else
>> -               return MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;
>> -
>> +               status =3D MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(struct mod_hdcp =
*hdcp)
>> @@ -232,7 +249,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryptio=
n(struct mod_hdcp *hdcp)
>>          struct psp_context *psp =3D hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct mod_hdcp_display *display =3D get_first_added_display(hd=
cp);
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -241,14 +260,15 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_encrypt=
ion(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION;
>> -
>> -       if (!is_dp_mst_hdcp(hdcp)) {
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION;
>> +       } else if (!is_dp_mst_hdcp(hdcp)) {
>>                  display->state =3D MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
>>                  HDCP_HDCP1_ENABLED_TRACE(hdcp, display->index);
>>          }
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist_vp(struct mod_hdc=
p *hdcp)
>> @@ -257,6 +277,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist=
_vp(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -287,6 +308,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist=
_vp(struct mod_hdcp *hdcp)
>>                  status =3D MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAIL=
URE;
>>          }
>>
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>>          return status;
>>   }
>>
>> @@ -296,7 +318,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream=
_encryption(struct mod_hdcp
>>          struct psp_context *psp =3D hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          int i =3D 0;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>
>>          for (i =3D 0; i < MAX_NUM_OF_DISPLAYS; i++) {
>> @@ -313,21 +337,26 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stre=
am_encryption(struct mod_hdcp
>>
>>                  psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -               if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -                       return MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRY=
PTION_FAILURE;
>> +               if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) =
{
>> +                       status =3D MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_E=
NCRYPTION_FAILURE;
>> +                       break;
>> +               }
>>
>>                  hdcp->displays[i].state =3D MOD_HDCP_DISPLAY_ENCRYPTION=
_ENABLED;
>>                  HDCP_HDCP1_ENABLED_TRACE(hdcp, hdcp->displays[i].index)=
;
>>          }
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_link_maintenance(struct mod_hdcp *=
hdcp)
>>   {
>>          struct psp_context *psp =3D hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> @@ -339,12 +368,12 @@ enum mod_hdcp_status mod_hdcp_hdcp1_link_maintenan=
ce(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILURE;
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS ||
>> +                       hdcp_cmd->out_msg.hdcp1_get_encryption_status.pr=
otection_level !=3D 1)
>> +               status =3D MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILUR=
E;
>>
>> -       return (hdcp_cmd->out_msg.hdcp1_get_encryption_status.protection=
_level =3D=3D 1)
>> -                      ? MOD_HDCP_STATUS_SUCCESS
>> -                      : MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILURE;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp1_get_link_encryption_status(struct =
mod_hdcp *hdcp,
>> @@ -365,18 +394,22 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session=
(struct mod_hdcp *hdcp)
>>          struct psp_context *psp =3D hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct mod_hdcp_display *display =3D get_first_added_display(hd=
cp);
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>> +
>>
>>          if (!psp->hdcp_context.hdcp_initialized) {
>>                  DRM_ERROR("Failed to create hdcp session, HDCP TA is no=
t initialized");
>>                  return MOD_HDCP_STATUS_FAILURE;
>>          }
>>
>> -       hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.h=
dcp_shared_buf;
>> -       memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> -
>>          if (!display)
>>                  return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>> +
>> +       hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.h=
dcp_shared_buf;
>> +       memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> +
>>          hdcp_cmd->in_msg.hdcp2_create_session_v2.display_handle =3D dis=
play->index;
>>
>>          if (hdcp->connection.link.adjust.hdcp2.force_type =3D=3D MOD_HD=
CP_FORCE_TYPE_0)
>> @@ -393,12 +426,14 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session=
(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_CREATE_SESSION_FAILURE;
>>
>> -       hdcp->auth.id =3D hdcp_cmd->out_msg.hdcp2_create_session_v2.sess=
ion_handle;
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> +               status =3D MOD_HDCP_STATUS_HDCP2_CREATE_SESSION_FAILURE;
>> +       else
>> +               hdcp->auth.id =3D hdcp_cmd->out_msg.hdcp2_create_session=
_v2.session_handle;
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *h=
dcp)
>> @@ -406,7 +441,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(=
struct mod_hdcp *hdcp)
>>          struct psp_context *psp =3D hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          uint8_t i =3D 0;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -415,20 +452,21 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destroy_sessio=
n(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FAILURE;
>> -
>> -       HDCP_TOP_HDCP2_DESTROY_SESSION_TRACE(hdcp);
>> -       for (i =3D 0; i < MAX_NUM_OF_DISPLAYS; i++)
>> -               if (is_display_encryption_enabled(
>> -                               &hdcp->displays[i])) {
>> -                       hdcp->displays[i].state =3D
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FAILURE=
;
>> +       } else {
>> +               HDCP_TOP_HDCP2_DESTROY_SESSION_TRACE(hdcp);
>> +               for (i =3D 0; i < MAX_NUM_OF_DISPLAYS; i++)
>> +                       if (is_display_encryption_enabled(&hdcp->display=
s[i])) {
>> +                               hdcp->displays[i].state =3D
>>                                          MOD_HDCP_DISPLAY_ACTIVE_AND_ADD=
ED;
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
>>   enum mod_hdcp_status mod_hdcp_hdcp2_prepare_ake_init(struct mod_hdcp *=
hdcp)
>> @@ -437,7 +475,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_ake_init=
(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_output_v2 *msg_out;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -452,12 +492,13 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_ake_in=
it(struct mod_hdcp *hdcp)
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>>          if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_PREP_AKE_INIT_FAILURE;
>> -
>> -       memcpy(&hdcp->auth.msg.hdcp2.ake_init[0], &msg_out->prepare.tran=
smitter_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.ake_init));
>> +               status =3D MOD_HDCP_STATUS_HDCP2_PREP_AKE_INIT_FAILURE;
>> +       else
>> +               memcpy(&hdcp->auth.msg.hdcp2.ake_init[0], &msg_out->prep=
are.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.ake_init));
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_ake_cert(struct mod_hdcp =
*hdcp)
>> @@ -466,7 +507,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_ake_cer=
t(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_output_v2 *msg_out;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -488,26 +531,32 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_ake_c=
ert(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE;
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.ake_no_stored_km, &msg_out->prepare.=
transmitter_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.ake_no_stored_km));
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.ake_stored_km,
>> -              &msg_out->prepare.transmitter_message[sizeof(hdcp->auth.m=
sg.hdcp2.ake_no_stored_km)],
>> -              sizeof(hdcp->auth.msg.hdcp2.ake_stored_km));
>> -
>> -       if (msg_out->process.msg1_status =3D=3D TA_HDCP2_MSG_AUTHENTICAT=
ION_STATUS__SUCCESS) {
>> -               hdcp->connection.is_km_stored =3D msg_out->process.is_km=
_stored ? 1 : 0;
>> -               hdcp->connection.is_repeater =3D msg_out->process.is_rep=
eater ? 1 : 0;
>> -               return MOD_HDCP_STATUS_SUCCESS;
>> -       } else if (msg_out->process.msg1_status =3D=3D TA_HDCP2_MSG_AUTH=
ENTICATION_STATUS__RECEIVERID_REVOKED) {
>> -               hdcp->connection.is_hdcp2_revoked =3D 1;
>> -               return MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED;
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILU=
RE;
>> +       } else {
>> +               memcpy(hdcp->auth.msg.hdcp2.ake_no_stored_km,
>> +                      &msg_out->prepare.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.ake_no_stored_km));
>> +
>> +               memcpy(hdcp->auth.msg.hdcp2.ake_stored_km,
>> +                      &msg_out->prepare.transmitter_message[sizeof(hdcp=
->auth.msg.hdcp2.ake_no_stored_km)],
>> +                      sizeof(hdcp->auth.msg.hdcp2.ake_stored_km));
>> +
>> +               if (msg_out->process.msg1_status =3D=3D
>> +                   TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS) {
>> +                       hdcp->connection.is_km_stored =3D
>> +                               msg_out->process.is_km_stored ? 1 : 0;
>> +                       hdcp->connection.is_repeater =3D
>> +                               msg_out->process.is_repeater ? 1 : 0;
>> +                       status =3D MOD_HDCP_STATUS_SUCCESS;
>> +               } else if (msg_out->process.msg1_status =3D=3D
>> +                          TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERI=
D_REVOKED) {
>> +                       hdcp->connection.is_hdcp2_revoked =3D 1;
>> +                       status =3D MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKE=
D;
>> +               }
>>          }
>> -
>> -       return MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_h_prime(struct mod_hdcp *=
hdcp)
>> @@ -516,7 +565,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_h_prime=
(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_output_v2 *msg_out;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -543,16 +594,15 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_h_pri=
me(struct mod_hdcp *hdcp)
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>>          if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE;
>> -
>> -       if (msg_out->process.msg1_status !=3D TA_HDCP2_MSG_AUTHENTICATIO=
N_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE;
>> +               status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILUR=
E;
>> +       else if (msg_out->process.msg1_status !=3D TA_HDCP2_MSG_AUTHENTI=
CATION_STATUS__SUCCESS)
>> +               status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILUR=
E;
>>          else if (!hdcp->connection.is_km_stored &&
>> -                msg_out->process.msg2_status !=3D TA_HDCP2_MSG_AUTHENTI=
CATION_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_PAIRING_INFO_FAILU=
RE;
>> -
>> +                  msg_out->process.msg2_status !=3D TA_HDCP2_MSG_AUTHEN=
TICATION_STATUS__SUCCESS)
>> +               status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_PAIRING_INFO_F=
AILURE;
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_prepare_lc_init(struct mod_hdcp *h=
dcp)
>> @@ -561,7 +611,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_lc_init(=
struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_output_v2 *msg_out;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -577,12 +629,13 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_lc_ini=
t(struct mod_hdcp *hdcp)
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>>          if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_PREP_LC_INIT_FAILURE;
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.lc_init, &msg_out->prepare.transmitt=
er_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.lc_init));
>> +               status =3D MOD_HDCP_STATUS_HDCP2_PREP_LC_INIT_FAILURE;
>> +       else
>> +               memcpy(hdcp->auth.msg.hdcp2.lc_init, &msg_out->prepare.t=
ransmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.lc_init));
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_l_prime(struct mod_hdcp *=
hdcp)
>> @@ -591,7 +644,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_l_prime=
(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_output_v2 *msg_out;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -610,13 +665,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_l_pri=
me(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE;
>> -
>> -       if (msg_out->process.msg1_status !=3D TA_HDCP2_MSG_AUTHENTICATIO=
N_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE;
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS ||
>> +                       msg_out->process.msg1_status !=3D TA_HDCP2_MSG_A=
UTHENTICATION_STATUS__SUCCESS)
>> +               status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILUR=
E;
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_prepare_eks(struct mod_hdcp *hdcp)
>> @@ -625,7 +679,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_eks(stru=
ct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_output_v2 *msg_out;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -642,20 +698,24 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_eks(st=
ruct mod_hdcp *hdcp)
>>          hdcp_cmd->cmd_id =3D TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUT=
HENTICATION_MSG_V2;
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_PREP_EKS_FAILURE;
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.ske_eks, &msg_out->prepare.transmitt=
er_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.ske_eks));
>> -       msg_out->prepare.msg1_desc.msg_size =3D sizeof(hdcp->auth.msg.hd=
cp2.ske_eks);
>> -
>> -       if (is_dp_hdcp(hdcp)) {
>> -               memcpy(hdcp->auth.msg.hdcp2.content_stream_type_dp,
>> -                      &msg_out->prepare.transmitter_message[sizeof(hdcp=
->auth.msg.hdcp2.ske_eks)],
>> -                      sizeof(hdcp->auth.msg.hdcp2.content_stream_type_d=
p));
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_HDCP2_PREP_EKS_FAILURE;
>> +       } else {
>> +               memcpy(hdcp->auth.msg.hdcp2.ske_eks,
>> +                      &msg_out->prepare.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.ske_eks));
>> +               msg_out->prepare.msg1_desc.msg_size =3D
>> +                       sizeof(hdcp->auth.msg.hdcp2.ske_eks);
>> +
>> +               if (is_dp_hdcp(hdcp)) {
>> +                       memcpy(hdcp->auth.msg.hdcp2.content_stream_type_=
dp,
>> +                              &msg_out->prepare.transmitter_message[siz=
eof(hdcp->auth.msg.hdcp2.ske_eks)],
>> +                              sizeof(hdcp->auth.msg.hdcp2.content_strea=
m_type_dp));
>> +               }
>>          }
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(struct mod_hdcp =
*hdcp)
>> @@ -663,27 +723,30 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_encrypt=
ion(struct mod_hdcp *hdcp)
>>          struct psp_context *psp =3D hdcp->config.psp.handle;
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct mod_hdcp_display *display =3D get_first_added_display(hd=
cp);
>> -
>> -       hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.h=
dcp_shared_buf;
>> -       memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>>          if (!display)
>>                  return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>> +
>> +       hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.h=
dcp_shared_buf;
>> +       memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> +
>>          hdcp_cmd->in_msg.hdcp2_set_encryption.session_handle =3D hdcp->=
auth.id;
>>
>>          hdcp_cmd->cmd_id =3D TA_HDCP_COMMAND__HDCP2_SET_ENCRYPTION;
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_FAILURE;
>> -
>> -       if (!is_dp_mst_hdcp(hdcp)) {
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_FAILU=
RE;
>> +       } else if (!is_dp_mst_hdcp(hdcp)) {
>>                  display->state =3D MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
>>                  HDCP_HDCP2_ENABLED_TRACE(hdcp, display->index);
>>          }
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id_list(struct mod_hdc=
p *hdcp)
>> @@ -692,6 +755,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id_l=
ist(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_output_v2 *msg_out;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>> +
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>> @@ -712,23 +778,26 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id=
_list(struct mod_hdcp *hdcp)
>>
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE=
;
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.repeater_auth_ack, &msg_out->prepare=
.transmitter_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.repeater_auth_ack));
>> -
>> -       if (msg_out->process.msg1_status =3D=3D TA_HDCP2_MSG_AUTHENTICAT=
ION_STATUS__SUCCESS) {
>> -               hdcp->connection.is_km_stored =3D msg_out->process.is_km=
_stored ? 1 : 0;
>> -               hdcp->connection.is_repeater =3D msg_out->process.is_rep=
eater ? 1 : 0;
>> -               return MOD_HDCP_STATUS_SUCCESS;
>> -       } else if (msg_out->process.msg1_status =3D=3D TA_HDCP2_MSG_AUTH=
ENTICATION_STATUS__RECEIVERID_REVOKED) {
>> -               hdcp->connection.is_hdcp2_revoked =3D 1;
>> -               return MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED;
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAI=
LURE;
>> +       } else {
>> +               memcpy(hdcp->auth.msg.hdcp2.repeater_auth_ack,
>> +                      &msg_out->prepare.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.repeater_auth_ack));
>> +
>> +               if (msg_out->process.msg1_status =3D=3D
>> +                   TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS) {
>> +                       hdcp->connection.is_km_stored =3D msg_out->proce=
ss.is_km_stored ? 1 : 0;
>> +                       hdcp->connection.is_repeater =3D msg_out->proces=
s.is_repeater ? 1 : 0;
>> +                       status =3D MOD_HDCP_STATUS_SUCCESS;
>> +               } else if (msg_out->process.msg1_status =3D=3D
>> +                          TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERI=
D_REVOKED) {
>> +                       hdcp->connection.is_hdcp2_revoked =3D 1;
>> +                       status =3D MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVO=
KED;
>> +               }
>>          }
>> -
>> -
>> -       return MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE;
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct=
 mod_hdcp *hdcp)
>> @@ -737,7 +806,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream=
_encryption(struct mod_hdcp
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_input_v2 *msg_in;
>>          uint8_t i;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -763,8 +834,13 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_strea=
m_encryption(struct mod_hdcp
>>                  HDCP_HDCP2_ENABLED_TRACE(hdcp, hdcp->displays[i].index)=
;
>>          }
>>
>> -       return (hdcp_cmd->hdcp_status =3D=3D TA_HDCP_STATUS__SUCCESS) ? =
MOD_HDCP_STATUS_SUCCESS
>> -                                                                 : MOD_=
HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION;
>> +       if (hdcp_cmd->hdcp_status =3D=3D TA_HDCP_STATUS__SUCCESS)
>> +               status =3D MOD_HDCP_STATUS_SUCCESS;
>> +       else
>> +               status =3D MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTIO=
N;
>> +
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream_management(struct m=
od_hdcp *hdcp)
>> @@ -774,7 +850,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream_m=
anagement(struct mod_hdcp *h
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_output_v2 *msg_out;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -789,15 +867,17 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream=
_management(struct mod_hdcp *h
>>          hdcp_cmd->cmd_id =3D TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUT=
HENTICATION_MSG_V2;
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)
>> -               return MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MANAGEMENT_F=
AILURE;
>> -
>> -       hdcp->auth.msg.hdcp2.stream_manage_size =3D msg_out->prepare.msg=
1_desc.msg_size;
>> -
>> -       memcpy(hdcp->auth.msg.hdcp2.repeater_auth_stream_manage, &msg_ou=
t->prepare.transmitter_message[0],
>> -              sizeof(hdcp->auth.msg.hdcp2.repeater_auth_stream_manage))=
;
>> +       if (hdcp_cmd->hdcp_status !=3D TA_HDCP_STATUS__SUCCESS) {
>> +               status =3D MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MANAGEME=
NT_FAILURE;
>> +       } else {
>> +               hdcp->auth.msg.hdcp2.stream_manage_size =3D msg_out->pre=
pare.msg1_desc.msg_size;
>>
>> -       return MOD_HDCP_STATUS_SUCCESS;
>> +               memcpy(hdcp->auth.msg.hdcp2.repeater_auth_stream_manage,
>> +                      &msg_out->prepare.transmitter_message[0],
>> +                      sizeof(hdcp->auth.msg.hdcp2.repeater_auth_stream_=
manage));
>> +       }
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(struct mod_h=
dcp *hdcp)
>> @@ -806,7 +886,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_=
ready(struct mod_hdcp *hdcp)
>>          struct ta_hdcp_shared_memory *hdcp_cmd;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_input_v2 *msg_in;
>>          struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message=
_output_v2 *msg_out;
>> +       enum mod_hdcp_status status =3D MOD_HDCP_STATUS_SUCCESS;
>>
>> +       mutex_lock(&psp->hdcp_context.mutex);
>>          hdcp_cmd =3D (struct ta_hdcp_shared_memory *)psp->hdcp_context.=
hdcp_shared_buf;
>>          memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
>>
>> @@ -825,10 +907,14 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_strea=
m_ready(struct mod_hdcp *hdcp)
>>          hdcp_cmd->cmd_id =3D TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUT=
HENTICATION_MSG_V2;
>>          psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
>>
>> -       return (hdcp_cmd->hdcp_status =3D=3D TA_HDCP_STATUS__SUCCESS) &&
>> -                              (msg_out->process.msg1_status =3D=3D TA_H=
DCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
>> -                      ? MOD_HDCP_STATUS_SUCCESS
>> -                      : MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_FAI=
LURE;
>> +       if (hdcp_cmd->hdcp_status =3D=3D TA_HDCP_STATUS__SUCCESS &&
>> +           msg_out->process.msg1_status =3D=3D TA_HDCP2_MSG_AUTHENTICAT=
ION_STATUS__SUCCESS)
>> +               status =3D MOD_HDCP_STATUS_SUCCESS;
>> +       else
>> +               status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_F=
AILURE;
>> +
>> +       mutex_unlock(&psp->hdcp_context.mutex);
>> +       return status;
>>   }
>>
>>   enum mod_hdcp_status mod_hdcp_hdcp2_get_link_encryption_status(struct =
mod_hdcp *hdcp,

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


--_000_MW3PR12MB45542A063E3FCF2E79A68B6EF9C80MW3PR12MB4554namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">mod_hdcp_hdcp2_get_link_enc=
ryption_status</span></font>() isn't being used, should probably remove it =
in a followup patch<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kazlauskas, Nicholas =
&lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Sent:</b> March 31, 2020 2:03 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Lakha, Bhawanpreet &=
lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx li=
st &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Guard calls to hdcp_ta and dtm=
_ta</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2020-03-31 1:37 p.m., Alex Deucher wrote:<br>
&gt; On Mon, Mar 30, 2020 at 6:36 PM Bhawanpreet Lakha<br>
&gt; &lt;Bhawanpreet.Lakha@amd.com&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; [Why]<br>
&gt;&gt; The buffer used when calling psp is a shared buffer. If we have mu=
ltiple calls<br>
&gt;&gt; at the same time we can overwrite the buffer.<br>
&gt;&gt;<br>
&gt;&gt; [How]<br>
&gt;&gt; Add mutex to guard the shared buffer.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;=
<br>
&gt; <br>
&gt; Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
One comment inline:<br>
<br>
&gt; <br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 &#43;<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 &#43;<br>
&gt;&gt;&nbsp;&nbsp; .../drm/amd/display/modules/hdcp/hdcp_psp.c&nbsp;&nbsp=
; | 420 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&gt;&gt;&nbsp;&nbsp; 3 files changed, 257 insertions(&#43;), 167 deletions(=
-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt;&gt; index dbaeffc4431e..9d587bc27663 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt;&gt; @@ -888,6 &#43;888,7 @@ static int psp_hdcp_load(struct psp_contex=
t *psp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;hdcp_context.hdcp_initialized =
=3D true;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;hdcp_context.session_id =3D cmd=
-&gt;resp.session_id;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;psp-&gt;hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(cmd);<=
br>
&gt;&gt; @@ -1033,6 &#43;1034,7 @@ static int psp_dtm_load(struct psp_conte=
xt *psp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;dtm_context.dtm_initialized =3D=
 true;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;dtm_context.session_id =3D cmd-=
&gt;resp.session_id;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;psp-&gt;dtm_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(cmd);<=
br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_psp.h<br>
&gt;&gt; index 297435c0c7c1..6a717fd5efc7 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&gt;&gt; @@ -161,6 &#43;161,7 @@ struct psp_hdcp_context {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgp=
u_bo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *hdcp_shared_bo;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; hdcp_shared_mc_addr;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *hdcp_shared_buf;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex;<br>
&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; struct psp_dtm_context {<br>
&gt;&gt; @@ -169,6 &#43;170,7 @@ struct psp_dtm_context {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgp=
u_bo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dtm_shared_bo;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; dtm_shared_mc_addr;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dtm_shared_buf;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex;<br>
&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; #define MEM_TRAIN_SYSTEM_SIGNATURE&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x54534942<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b=
/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c<br>
&gt;&gt; index c2929815c3ee..aa147e171557 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ps=
p.c<br>
&gt;&gt; @@ -51,12 &#43;51,15 @@ enum mod_hdcp_status mod_hdcp_remove_displ=
ay_from_topology(<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_dt=
m_shared_memory *dtm_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_h=
dcp_display *display =3D<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; get_active_display_at_index(hdcp, index);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dtm_cmd =3D =
(struct ta_dtm_shared_memory *)psp-&gt;dtm_context.dtm_shared_buf;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!display=
 || !is_display_added(display))<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_DISPLAY_NOT_FOUN=
D;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
dtm_context.mutex);<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(dtm_c=
md, 0, sizeof(struct ta_dtm_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dtm_cmd-&gt;=
cmd_id =3D TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2;<br>
&gt;&gt; @@ -66,14 &#43;69,15 @@ enum mod_hdcp_status mod_hdcp_remove_displ=
ay_from_topology(<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_dtm_invo=
ke(psp, dtm_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dtm_cmd-&gt;dtm_status !=
=3D TA_DTM_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dtm_cmd-&gt;dtm_stat=
us !=3D TA_DTM_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; display-&gt;state =3D MOD_HDCP_DISPLAY_ACTIVE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; HDCP_TOP_REMOVE_DISPLAY_TRACE(hdcp, display-&gt;ind=
ex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;state =3D MOD_HD=
CP_DISPLAY_ACTIVE;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_TOP_REMOVE_DISPLAY_TRAC=
E(hdcp, display-&gt;index);<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; -<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;dtm_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_add_display_to_topology(=
struct mod_hdcp *hdcp,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t index)<br>
&gt;&gt; @@ -83,6 &#43;87,7 @@ enum mod_hdcp_status mod_hdcp_add_display_to=
_topology(struct mod_hdcp *hdcp,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_h=
dcp_display *display =3D<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; get_active_display_at_index(hdcp, index);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_h=
dcp_link *link =3D &amp;hdcp-&gt;connection.link;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt=
;dtm_context.dtm_initialized) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to add display t=
opology, DTM TA is not initialized.&quot;);<br>
&gt;&gt; @@ -94,6 &#43;99,7 @@ enum mod_hdcp_status mod_hdcp_add_display_to=
_topology(struct mod_hdcp *hdcp,<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dtm_cmd =3D =
(struct ta_dtm_shared_memory *)psp-&gt;dtm_context.dtm_shared_buf;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
dtm_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(dtm_c=
md, 0, sizeof(struct ta_dtm_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dtm_cmd-&gt;=
cmd_id =3D TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2;<br>
&gt;&gt; @@ -113,13 &#43;119,15 @@ enum mod_hdcp_status mod_hdcp_add_displa=
y_to_topology(struct mod_hdcp *hdcp,<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_dtm_invo=
ke(psp, dtm_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dtm_cmd-&gt;dtm_status !=
=3D TA_DTM_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;state =3D MOD_HD=
CP_DISPLAY_ACTIVE_AND_ADDED;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_TOP_ADD_DISPLAY_TRACE(h=
dcp, display-&gt;index);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dtm_cmd-&gt;dtm_stat=
us !=3D TA_DTM_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; display-&gt;state =3D MOD_HDCP_DISPLAY_ACTIVE_AND_A=
DDED;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display-&gt;index)=
;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;dtm_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp1_create_session(str=
uct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -128,6 &#43;136,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create=
_session(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_c=
ontext *psp =3D hdcp-&gt;config.psp.handle;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_h=
dcp_display *display =3D get_first_added_display(hdcp);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt=
;hdcp_context.hdcp_initialized) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to create hdcp s=
ession. HDCP TA is not initialized.&quot;);<br>
&gt;&gt; @@ -135,6 &#43;144,8 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create=
_session(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd-&gt=
;in_msg.hdcp1_create_session.display_handle =3D display-&gt;index;<br>
&gt;&gt; @@ -144,16 &#43;155,18 @@ enum mod_hdcp_status mod_hdcp_hdcp1_crea=
te_session(struct mod_hdcp *hdcp)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;aut=
h.id =3D hdcp_cmd-&gt;out_msg.hdcp1_create_session.session_handle;<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAILURE;<br=
>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;auth.msg.hdcp1.ainf=
o =3D hdcp_cmd-&gt;out_msg.hdcp1_create_session.ainfo_primary;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdc=
p1.aksv, hdcp_cmd-&gt;out_msg.hdcp1_create_session.aksv_primary,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sizeof(hdcp-&gt;auth.msg.hdcp1.aksv));<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdc=
p1.an, hdcp_cmd-&gt;out_msg.hdcp1_create_session.an_primary,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sizeof(hdcp-&gt;auth.msg.hdcp1.an));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAI=
LURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;auth.msg.hdcp1.ainfo =3D hdcp_cmd-&gt;out_=
msg.hdcp1_create_session.ainfo_primary;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdcp1.aksv, hdcp_cmd-&gt;o=
ut_msg.hdcp1_create_session.aksv_primary,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hd=
cp-&gt;auth.msg.hdcp1.aksv));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdcp1.an, hdcp_cmd-&gt;out=
_msg.hdcp1_create_session.an_primary,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hd=
cp-&gt;auth.msg.hdcp1.an));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(st=
ruct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -162,7 &#43;175,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destro=
y_session(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_c=
ontext *psp =3D hdcp-&gt;config.psp.handle;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t i =
=3D 0;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -171,27 &#43;186,30 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dest=
roy_session(struct mod_hdcp *hdcp)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FAILURE;<b=
r>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_TOP_HDCP1_DESTROY_SESSI=
ON_TRACE(hdcp);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MAX_NUM=
_OF_DISPLAYS; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (is_display_encryption_enabled(<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hdcp-&gt;displays[i])) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&g=
t;displays[i].state =3D<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FA=
ILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; HDCP_TOP_HDCP1_DESTROY_SESSION_TRACE(hdcp);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MAX_NUM_OF_DISPLAYS; i&#43;&#4=
3;)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(is_display_encryption_enabled(&amp;hdcp-&gt;displays[i])) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;displays[i].state =3D=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_HD=
CP1_DISABLED_TRACE(hdcp,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; hdcp-&gt;displays[i].index);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_HDCP1_DISABLED_TRACE(<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; hdcp, hdcp-&gt;displays[i].index);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(struct=
 mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_c=
ontext *psp =3D hdcp-&gt;config.psp.handle;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -206,10 &#43;224,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_valid=
ate_rx(struct mod_hdcp *hdcp)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;out_msg.hdc=
p1_first_part_authentication.authentication_status =3D=3D<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILUR=
E;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (hdcp_cmd-&gt;=
out_msg.hdcp1_first_part_authentication.authentication_status =3D=3D<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; TA_HDCP_AUTHENTICATION_STATUS__HDCP1_FIRST_PART_COMPLETE) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* needs second part of authentication =
*/<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;connection.is_repeater =3D 1;<=
br>
&gt;&gt; @@ -219,12 &#43;236,12 @@ enum mod_hdcp_status mod_hdcp_hdcp1_vali=
date_rx(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (h=
dcp_cmd-&gt;out_msg.hdcp1_first_part_authentication.authentication_status =
=3D=3D<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_HDCP_AUTHENTICATIO=
N_STATUS__HDCP1_KSV_REVOKED) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;connection.is_hdcp1_revoked =
=3D 1;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;<br>
&gt;&gt; -<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILUR=
E;<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(=
struct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -232,7 &#43;249,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable=
_encryption(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_c=
ontext *psp =3D hdcp-&gt;config.psp.handle;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_h=
dcp_display *display =3D get_first_added_display(hdcp);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -241,14 &#43;260,15 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enab=
le_encryption(struct mod_hdcp *hdcp)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!is_dp_mst_hdcp(hdcp)) {=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION;=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!is_dp_mst_hd=
cp(hdcp)) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;state =3D MOD_HDCP_DISPLAY_=
ENCRYPTION_ENABLED;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_HDCP1_ENABLED_TRACE(hdcp, display-=
&gt;index);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist_v=
p(struct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -257,6 &#43;277,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_valida=
te_ksvlist_vp(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdc=
p_status status =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -287,6 &#43;308,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_valida=
te_ksvlist_vp(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP1_VALIDA=
TE_KSV_LIST_FAILURE;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return statu=
s;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; @@ -296,7 &#43;318,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable=
_dp_stream_encryption(struct mod_hdcp<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_c=
ontext *psp =3D hdcp-&gt;config.psp.handle;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0=
; i &lt; MAX_NUM_OF_DISPLAYS; i&#43;&#43;) {<br>
&gt;&gt; @@ -313,21 &#43;337,26 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enab=
le_dp_stream_encryption(struct mod_hdcp<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_invoke(psp, hdcp_cmd-&gt;cmd_i=
d);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status !=3D TA_HDCP_STATUS__SUCCE=
SS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status !=3D TA_HDCP_STATUS__S=
UCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sta=
tus =3D MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bre=
ak;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;displays[i].state =3D MOD_HDCP=
_DISPLAY_ENCRYPTION_ENABLED;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_HDCP1_ENABLED_TRACE(hdcp, hdcp-&gt=
;displays[i].index);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp1_link_maintenance(s=
truct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_c=
ontext *psp =3D hdcp-&gt;config.psp.handle;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt; @@ -339,12 &#43;368,12 @@ enum mod_hdcp_status mod_hdcp_hdcp1_link=
_maintenance(struct mod_hdcp *hdcp)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILURE;<=
br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS ||<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdc=
p_cmd-&gt;out_msg.hdcp1_get_encryption_status.protection_level !=3D 1)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_F=
AILURE;<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (hdcp_cmd-&gt;out_msg=
.hdcp1_get_encryption_status.protection_level =3D=3D 1)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ? MOD_HDCP_ST=
ATUS_SUCCESS<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : MOD_HDCP_ST=
ATUS_HDCP1_LINK_MAINTENANCE_FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp1_get_link_encryptio=
n_status(struct mod_hdcp *hdcp,<br>
&gt;&gt; @@ -365,18 &#43;394,22 @@ enum mod_hdcp_status mod_hdcp_hdcp2_crea=
te_session(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_c=
ontext *psp =3D hdcp-&gt;config.psp.handle;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_h=
dcp_display *display =3D get_first_added_display(hdcp);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt; &#43;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt=
;hdcp_context.hdcp_initialized) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to create hdcp s=
ession, HDCP TA is not initialized&quot;);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_FAILURE;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D (struct ta_hdcp=
_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_cmd, 0, sizeof(s=
truct ta_hdcp_shared_memory));<br>
&gt;&gt; -<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!display=
)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_DISPLAY_NOT_FOUN=
D;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D (struct ta_=
hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_cmd, 0, size=
of(struct ta_hdcp_shared_memory));<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd-&gt=
;in_msg.hdcp2_create_session_v2.display_handle =3D display-&gt;index;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp-&gt=
;connection.link.adjust.hdcp2.force_type =3D=3D MOD_HDCP_FORCE_TYPE_0)<br>
&gt;&gt; @@ -393,12 &#43;426,14 @@ enum mod_hdcp_status mod_hdcp_hdcp2_crea=
te_session(struct mod_hdcp *hdcp)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_CREATE_SESSION_FAILURE;<br=
>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;auth.id =3D hdcp_cm=
d-&gt;out_msg.hdcp2_create_session_v2.session_handle;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_CREATE_SESSION_FAI=
LURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;auth.id =3D hdcp_cmd-&gt;out_msg.hdcp2_cre=
ate_session_v2.session_handle;<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(st=
ruct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -406,7 &#43;441,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destro=
y_session(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_c=
ontext *psp =3D hdcp-&gt;config.psp.handle;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t i =
=3D 0;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -415,20 &#43;452,21 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dest=
roy_session(struct mod_hdcp *hdcp)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FAILURE;<b=
r>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_TOP_HDCP2_DESTROY_SESSI=
ON_TRACE(hdcp);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MAX_NUM=
_OF_DISPLAYS; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (is_display_encryption_enabled(<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hdcp-&gt;displays[i])) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&g=
t;displays[i].state =3D<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FA=
ILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; HDCP_TOP_HDCP2_DESTROY_SESSION_TRACE(hdcp);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MAX_NUM_OF_DISPLAYS; i&#43;&#4=
3;)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(is_display_encryption_enabled(&amp;hdcp-&gt;displays[i])) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;displays[i].state =3D=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_HD=
CP2_DISABLED_TRACE(hdcp,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; hdcp-&gt;displays[i].index);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_HDCP2_DISABLED_TRACE(<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; hdcp, hdcp-&gt;displays[i].index);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_prepare_ake_init(s=
truct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -437,7 &#43;475,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepar=
e_ake_init(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -452,12 &#43;492,13 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prep=
are_ake_init(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd=
-&gt;hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_PREP_AKE_INIT_FAILURE;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;hdcp-&gt;auth.ms=
g.hdcp2.ake_init[0], &amp;msg_out-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; sizeof(hdcp-&gt;auth.msg.hdcp2.ake_init));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_PREP_AKE_INIT_FAIL=
URE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;hdcp-&gt;auth.msg.hdcp2.ake_init[0], &a=
mp;msg_out-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hd=
cp-&gt;auth.msg.hdcp2.ake_init));<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_validate_ake_cert(=
struct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -466,7 &#43;507,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_valida=
te_ake_cert(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -488,26 &#43;531,32 @@ enum mod_hdcp_status mod_hdcp_hdcp2_vali=
date_ake_cert(struct mod_hdcp *hdcp)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE;=
<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdc=
p2.ake_no_stored_km, &amp;msg_out-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; sizeof(hdcp-&gt;auth.msg.hdcp2.ake_no_stored_km));<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdc=
p2.ake_stored_km,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;msg_out-&gt;prepare.transmitter_message[sizeof(hdcp-&gt;=
auth.msg.hdcp2.ake_no_stored_km)],<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; sizeof(hdcp-&gt;auth.msg.hdcp2.ake_stored_km));<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msg_out-&gt;process.msg1=
_status =3D=3D TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdcp-&gt;connection.is_km_stored =3D msg_out-&gt;proces=
s.is_km_stored ? 1 : 0;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdcp-&gt;connection.is_repeater =3D msg_out-&gt;process=
.is_repeater ? 1 : 0;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (msg_out-&gt;proce=
ss.msg1_status =3D=3D TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKE=
D) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdcp-&gt;connection.is_hdcp2_revoked =3D 1;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_=
FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdcp2.ake_no_stored_km,<br=
>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;msg_=
out-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hd=
cp-&gt;auth.msg.hdcp2.ake_no_stored_km));<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdcp2.ake_stored_km,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;msg_=
out-&gt;prepare.transmitter_message[sizeof(hdcp-&gt;auth.msg.hdcp2.ake_no_s=
tored_km)],<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hd=
cp-&gt;auth.msg.hdcp2.ake_stored_km));<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (msg_out-&gt;process.msg1_status =3D=3D<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_HDCP2_MSG_AUTHENTICATION=
_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdc=
p-&gt;connection.is_km_stored =3D<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg_out-&gt;process.is_km_stor=
ed ? 1 : 0;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdc=
p-&gt;connection.is_repeater =3D<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg_out-&gt;process.is_repeate=
r ? 1 : 0;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; } else if (msg_out-&gt;process.msg1_status =3D=3D<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {<br=
>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdc=
p-&gt;connection.is_hdcp2_revoked =3D 1;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sta=
tus =3D MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2=
_VALIDATE_AKE_CERT_FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_validate_h_prime(s=
truct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -516,7 &#43;565,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_valida=
te_h_prime(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -543,16 &#43;594,15 @@ enum mod_hdcp_status mod_hdcp_hdcp2_vali=
date_h_prime(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd=
-&gt;hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE;<=
br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msg_out-&gt;process.msg1=
_status !=3D TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE;<=
br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_F=
AILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (msg_out-&gt;pro=
cess.msg1_status !=3D TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_F=
AILURE;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (!hd=
cp-&gt;connection.is_km_stored &amp;&amp;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; msg_out-&gt;process.msg2_status !=3D TA_HDCP2_MSG=
_AUTHENTICATION_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_VALIDATE_PAIRING_INFO_FAIL=
URE;<br>
&gt;&gt; -<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg_out-&gt;process.msg2_status !=
=3D TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_PAIRING_I=
NFO_FAILURE;<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_prepare_lc_init(st=
ruct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -561,7 &#43;611,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepar=
e_lc_init(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -577,12 &#43;629,13 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prep=
are_lc_init(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd=
-&gt;hdcp_status !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_PREP_LC_INIT_FAILURE;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdc=
p2.lc_init, &amp;msg_out-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; sizeof(hdcp-&gt;auth.msg.hdcp2.lc_init));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_PREP_LC_INIT_FAILU=
RE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdcp2.lc_init, &amp;msg_ou=
t-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hd=
cp-&gt;auth.msg.hdcp2.lc_init));<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_validate_l_prime(s=
truct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -591,7 &#43;644,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_valida=
te_l_prime(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -610,13 &#43;665,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_vali=
date_l_prime(struct mod_hdcp *hdcp)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE;<=
br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msg_out-&gt;process.msg1=
_status !=3D TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE;<=
br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS ||<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg=
_out-&gt;process.msg1_status !=3D TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCE=
SS)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_F=
AILURE;<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_prepare_eks(struct=
 mod_hdcp *hdcp)<br>
&gt;&gt; @@ -625,7 &#43;679,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepar=
e_eks(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -642,20 &#43;698,24 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prep=
are_eks(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd-&gt=
;cmd_id =3D TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUTHENTICATION_MSG_V2;<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_PREP_EKS_FAILURE;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdc=
p2.ske_eks, &amp;msg_out-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; sizeof(hdcp-&gt;auth.msg.hdcp2.ske_eks));<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg_out-&gt;prepare.msg1_des=
c.msg_size =3D sizeof(hdcp-&gt;auth.msg.hdcp2.ske_eks);<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_dp_hdcp(hdcp)) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdcp2.content_stream_type_dp,<=
br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;msg_out-=
&gt;prepare.transmitter_message[sizeof(hdcp-&gt;auth.msg.hdcp2.ske_eks)],<b=
r>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hdcp-&=
gt;auth.msg.hdcp2.content_stream_type_dp));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_PREP_EKS_FAILURE;<=
br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdcp2.ske_eks,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;msg_=
out-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hd=
cp-&gt;auth.msg.hdcp2.ske_eks));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; msg_out-&gt;prepare.msg1_desc.msg_size =3D<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
eof(hdcp-&gt;auth.msg.hdcp2.ske_eks);<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (is_dp_hdcp(hdcp)) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
cpy(hdcp-&gt;auth.msg.hdcp2.content_stream_type_dp,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;msg_out-&gt;prepare.transmitter=
_message[sizeof(hdcp-&gt;auth.msg.hdcp2.ske_eks)],<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hdcp-&gt;auth.msg.hdcp2.conte=
nt_stream_type_dp));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(=
struct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -663,27 &#43;723,30 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enab=
le_encryption(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_c=
ontext *psp =3D hdcp-&gt;config.psp.handle;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_h=
dcp_display *display =3D get_first_added_display(hdcp);<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D (struct ta_hdcp=
_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_cmd, 0, sizeof(s=
truct ta_hdcp_shared_memory));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!display=
)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_DISPLAY_NOT_FOUN=
D;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D (struct ta_=
hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_cmd, 0, size=
of(struct ta_hdcp_shared_memory));<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd-&gt=
;in_msg.hdcp2_set_encryption.session_handle =3D hdcp-&gt;auth.id;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd-&gt=
;cmd_id =3D TA_HDCP_COMMAND__HDCP2_SET_ENCRYPTION;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_FAILURE;=
<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!is_dp_mst_hdcp(hdcp)) {=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_=
FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!is_dp_mst_hd=
cp(hdcp)) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;state =3D MOD_HDCP_DISPLAY_=
ENCRYPTION_ENABLED;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_HDCP2_ENABLED_TRACE(hdcp, display-=
&gt;index);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id_lis=
t(struct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -692,6 &#43;755,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_valida=
te_rx_id_list(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt; @@ -712,23 &#43;778,26 @@ enum mod_hdcp_status mod_hdcp_hdcp2_vali=
date_rx_id_list(struct mod_hdcp *hdcp)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILUR=
E;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdc=
p2.repeater_auth_ack, &amp;msg_out-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; sizeof(hdcp-&gt;auth.msg.hdcp2.repeater_auth_ack));<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msg_out-&gt;process.msg1=
_status =3D=3D TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdcp-&gt;connection.is_km_stored =3D msg_out-&gt;proces=
s.is_km_stored ? 1 : 0;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdcp-&gt;connection.is_repeater =3D msg_out-&gt;process=
.is_repeater ? 1 : 0;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (msg_out-&gt;proce=
ss.msg1_status =3D=3D TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKE=
D) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdcp-&gt;connection.is_hdcp2_revoked =3D 1;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIS=
T_FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdcp2.repeater_auth_ack,<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;msg_=
out-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hd=
cp-&gt;auth.msg.hdcp2.repeater_auth_ack));<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (msg_out-&gt;process.msg1_status =3D=3D<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_HDCP2_MSG_AUTHENTICATION=
_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdc=
p-&gt;connection.is_km_stored =3D msg_out-&gt;process.is_km_stored ? 1 : 0;=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdc=
p-&gt;connection.is_repeater =3D msg_out-&gt;process.is_repeater ? 1 : 0;<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; } else if (msg_out-&gt;process.msg1_status =3D=3D<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {<br=
>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdc=
p-&gt;connection.is_hdcp2_revoked =3D 1;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sta=
tus =3D MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2=
_VALIDATE_RX_ID_LIST_FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_e=
ncryption(struct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -737,7 &#43;806,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable=
_dp_stream_encryption(struct mod_hdcp<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t i;<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -763,8 &#43;834,13 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enabl=
e_dp_stream_encryption(struct mod_hdcp<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDCP_HDCP2_ENABLED_TRACE(hdcp, hdcp-&gt=
;displays[i].index);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (hdcp_cmd-&gt;hdcp_st=
atus =3D=3D TA_HDCP_STATUS__SUCCESS) ? MOD_HDCP_STATUS_SUCCESS<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; : MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus =3D=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCR=
YPTION;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream_man=
agement(struct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -774,7 &#43;850,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepar=
e_stream_management(struct mod_hdcp *h<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -789,15 &#43;867,17 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prep=
are_stream_management(struct mod_hdcp *h<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd-&gt=
;cmd_id =3D TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUTHENTICATION_MSG_V2;<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_status=
 !=3D TA_HDCP_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MANAGEMENT_=
FAILURE;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;auth.msg.hdcp2.stre=
am_manage_size =3D msg_out-&gt;prepare.msg1_desc.msg_size;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdc=
p2.repeater_auth_stream_manage, &amp;msg_out-&gt;prepare.transmitter_messag=
e[0],<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; sizeof(hdcp-&gt;auth.msg.hdcp2.repeater_auth_stream_manage));=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus !=3D TA_HDCP_STATUS__SUCCESS) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MAN=
AGEMENT_FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; hdcp-&gt;auth.msg.hdcp2.stream_manage_size =3D msg_=
out-&gt;prepare.msg1_desc.msg_size;<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MOD_HDCP_STATUS_SUCCE=
SS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; memcpy(hdcp-&gt;auth.msg.hdcp2.repeater_auth_stream=
_manage,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;msg_=
out-&gt;prepare.transmitter_message[0],<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(hd=
cp-&gt;auth.msg.hdcp2.repeater_auth_stream_manage));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_re=
ady(struct mod_hdcp *hdcp)<br>
&gt;&gt; @@ -806,7 &#43;886,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_valida=
te_stream_ready(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_shared_memory *hdcp_cmd;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_hd=
cp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status sta=
tus =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;=
hdcp_context.mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd =3D=
 (struct ta_hdcp_shared_memory *)psp-&gt;hdcp_context.hdcp_shared_buf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hdcp_=
cmd, 0, sizeof(struct ta_hdcp_shared_memory));<br>
&gt;&gt;<br>
&gt;&gt; @@ -825,10 &#43;907,14 @@ enum mod_hdcp_status mod_hdcp_hdcp2_vali=
date_stream_ready(struct mod_hdcp *hdcp)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_cmd-&gt=
;cmd_id =3D TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUTHENTICATION_MSG_V2;<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_hdcp_inv=
oke(psp, hdcp_cmd-&gt;cmd_id);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (hdcp_cmd-&gt;hdcp_st=
atus =3D=3D TA_HDCP_STATUS__SUCCESS) &amp;&amp;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (msg_out-&gt;process.msg1_status =3D=3D =
TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ? MOD_HDCP_ST=
ATUS_SUCCESS<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : MOD_HDCP_ST=
ATUS_HDCP2_VALIDATE_STREAM_READY_FAILURE;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_cmd-&gt;hdcp_st=
atus =3D=3D TA_HDCP_STATUS__SUCCESS &amp;&amp;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
msg_out-&gt;process.msg1_status =3D=3D TA_HDCP2_MSG_AUTHENTICATION_STATUS__=
SUCCESS)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_SUCCESS;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_RE=
ADY_FAILURE;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&g=
t;hdcp_context.mutex);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; enum mod_hdcp_status mod_hdcp_hdcp2_get_link_encryptio=
n_status(struct mod_hdcp *hdcp,<br>
<br>
Looks like you're missing a mutex in this function ^<br>
<br>
mod_hdcp_hdcp2_get_link_encryption_status<br>
<br>
Which touches hdcp_shared_buf.<br>
<br>
Nicholas Kazlauskas<br>
<br>
&gt;&gt; --<br>
&gt;&gt; 2.17.1<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB45542A063E3FCF2E79A68B6EF9C80MW3PR12MB4554namp_--

--===============0809383404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0809383404==--
