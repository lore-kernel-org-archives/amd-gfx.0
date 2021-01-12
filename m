Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4537C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 05:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF0A222F9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 05:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF0A222F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D699289F01;
	Tue, 12 Jan 2021 05:55:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5F589F01
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 05:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJF/ity1HGdW19RAKZQReEJ3NYxCldd7iIW8HaB0K1bSdmsHtlM/xg9qXyFGtsjBdAG01WHSfJ1O+nhdqyT35L/PmG4jywIX0uwjQL5qZgXEBzlCLV4FmtYzGU8TIDN4hcuYB40w2hk9S9oQsxirZj4FfmboW45ql1UZMrOURQIqBNwjpsKpihXfuvZMtSPN0nHIO9iK7rwbtMvEJAOADljBgBlx7IUR6Hw8J/RunSGJBg3l/DoZP4UQdxuotibmqXVZpTMHabkcfPf+UmFfteNl7W1wv1x+s1UGgqIkd5afKZ0ZBO8nGPlrpyfnUcr/+03HWcIpP8Fn4xpYtEo21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCkj+quLs13a3e89K4kecfgjzmdYW2+vj0LgwmD/LS4=;
 b=LG4te43r76lZDMLvU61roYL88uZVjOf/ucUXjhi+LpGrd/OVUlGCe0WPFA31vHYw7WqUmrxQrJ2dKy51vM2Srr5NN+VmMZBI6tENULk2WDqTvPYWT3WEmZ2zqIVqbZCXAwBXdFHICAalvkNkYBH+LRAFxobblvbAaqRXGpxQCCtU61C3vS2170IvbHj2wQXXdmGdHKeWJvrWWBYTEegYOiAz85pJJCAOoQluDqftVNXVH+PneZPeDbfUvVgZDFke2jR1tkNf1mA6ewnlBbrsHiZeYuJ7iTaxqnn0mlwAG3Jm11Z8v3qlacSyWSJBWJcuEO9xW4nRd9InSELLo909dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCkj+quLs13a3e89K4kecfgjzmdYW2+vj0LgwmD/LS4=;
 b=sM1NTfPmxjRYMnmEHl9ZdkQJkkit4shpsiRoNQS+RVmTwRxoP9p4tyxXkOefXUi6TXYFEFPXYlCZ+cepmXhzjgNB2eTBGy0arL5HBUEcB8YUd31p5MvX9zErKKu3oBJHNpyjF2V65ovPyQgMtVtG0XWPsl3QNhL2RUTmx6HSOWw=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB2503.namprd12.prod.outlook.com (2603:10b6:4:b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 12 Jan
 2021 05:55:43 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::44aa:dfd4:9:1590]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::44aa:dfd4:9:1590%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:55:43 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, JingWen" <JingWen.Chen2@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>
Subject: RE: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset
Thread-Topic: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset
Thread-Index: AQHW5OKEwutYSgw3DkK5edpNmlHSz6odDOYAgAZM2ICAAClHEA==
Date: Tue, 12 Jan 2021 05:55:43 +0000
Message-ID: <DM5PR12MB170820A3CBD347D2D887B07984AA0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20210107104656.24107-1-Jack.Zhang1@amd.com>
 <DM5PR1201MB0204502D7A2095C9AF1795C0BBAE0@DM5PR1201MB0204.namprd12.prod.outlook.com>
 <DM5PR1201MB02046506D8550CED777EE551BBAA0@DM5PR1201MB0204.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB02046506D8550CED777EE551BBAA0@DM5PR1201MB0204.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-12T05:55:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d0d1ba6e-b149-4b7f-a9da-0000028f0285;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b886ec1-2535-4a52-f32e-08d8b6beb309
x-ms-traffictypediagnostic: DM5PR12MB2503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB250336A8BB515795CFAD970D84AA0@DM5PR12MB2503.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yY9G0QF8CAfILWzNGPg1kLkd9YYxGcr7LURXYrKNf5BReT1YwACxHTWSCOMmXNcoTL7KWGL4Lr67ChUsIhOQRydYeSSNlqIm4hk70AsPdYXv8EDYDETS3eHhPMkvx9L5EuXjciLuV/BafRkEFYsLLM3Cq7ffsh1UccQYBnaSLgFFL+rpOhgQabuzrKDZ0Hse6GMWCYp0RctTuUymo7HJa290rT9Vy0DRkC7IiLz3Vi36D9UZZ7OcRL7WT8Dl99il6U3xWM3D8QYprsOiSdyC2MNt7bqpqNh7m6Hfo38XBX202VMJzIJVuaoVrfNi3tM8f8WjWCrT2mzdT1SKZjq1C/Bp850KcuchmIFMck5kR2FWOF4lVrRu5lfx6st1SgjcKBivPV37jl+YefBM6w9ogSJip2yj13rbwyAV6jSjsjku2oAKLpXxbLJLXMaiTV5W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(110136005)(186003)(8936002)(316002)(83380400001)(7696005)(52536014)(6636002)(2906002)(53546011)(55016002)(6506007)(9686003)(86362001)(5660300002)(921005)(33656002)(26005)(66556008)(66946007)(64756008)(66446008)(8676002)(66476007)(478600001)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?cUxMb2tZM2o3b1djTlp6TSs5Z1pUWXhzcENhbXdYdjhrcFI4Wm10bjUzUUtW?=
 =?utf-8?B?TVM0MHlzMnIyaEFuQk9HWlV3Y29uMjNyWjA0OHBJWXRtMTdCTGdySVBzdko0?=
 =?utf-8?B?TlpCUTNlK0xmU1hyNDZub08yYTVUL3ZnM1dQcVhjOUZhSHlma3JDNW0rTVBx?=
 =?utf-8?B?SVl5Z2ZCcVZjUUFjMHVacFlrUklaaUpUUEpjV29zc21FTzcyY2RnUGZKeGR1?=
 =?utf-8?B?TVY0ZzV2QXh6bngwdlhGRHd0dW1ZNG5LNC90L2VQclJ3L3F2VmpFTWNsR01S?=
 =?utf-8?B?SXN6ZVd1Z2s0L1VSalE1ODRkVGFwTThneUFHODA0eHF3SVp5dmFFcHZpSHEz?=
 =?utf-8?B?V2pZaEFuVUtGREU3TWYyTmJMNXRZc29WRlR1Vy8rbzRkbkN0ajg3MDdKNGR4?=
 =?utf-8?B?aDB2Tm5zanplWnJGQkQ1V1dqWlBabHlPVTA3L2U5MUxkOUZSUmlLT0d4L0tM?=
 =?utf-8?B?WFVnQWNneFdsMUx5U1h0WFg2ZUlza0VhRVkxbDB1UktWVngrcjRLRmZEYXBM?=
 =?utf-8?B?amExRUg2MUVTSmFBeWtZM3dRMUZQYTl3WHRpNjdrNGs0RVkxMnJ5Ujd3bVl1?=
 =?utf-8?B?SGxwSUgwRXRCbUVrUEdVVHZZcitIdVFwcWFhL2JiQkNxR2NXOUlaUDk1WEZF?=
 =?utf-8?B?dHdCZkdYZVBhdXFORnZmTEkzcFZkdFM5R0RmVXlNS21hajMveXNEd2dYcnRH?=
 =?utf-8?B?WFNpT1NLbXpyTklPVXZPVWpZVXRQcExJdVRkSlZCN0pkV3BxRmVqZjladSt6?=
 =?utf-8?B?WVBTcUNEa0FqdHFKU1Y4YmtDR3MvUW1rS0NOMzRMVFRuNDFteEJYaE1BekVY?=
 =?utf-8?B?MDc1K2VPMnViVk9HN1V6UTg3YUtvMGtwTERCK1hqVXA3aFk5UjZDZUdSUVJ3?=
 =?utf-8?B?SkI4bXc4MWpPYzd6bW51YmR5L3o1VHZEZlNvNkhVTHVHMHI0WXJYYXZsUzJO?=
 =?utf-8?B?MXl6dVYva2E4bXZUVkVYbzUyMmRkS1JVcFhrbjkzQVNZOVU3YW9BVW9pWkw4?=
 =?utf-8?B?d2NmSXdZeWs5aFRKNWdiblE3ZzVnLzgvUWYrVk5EM2RLMHo1M24vM1JEVHJt?=
 =?utf-8?B?R2tRbVJIZ1NZenR5Y0xMOGE5OTZNT2ZoQWNCMmdHMUYrdE1nV21EamdyYkgw?=
 =?utf-8?B?eVFZcGhVelFXRkpzSFBsVklVYTlkRy9Td1EyQ2pQZmpZanVJVndVTVhDbk02?=
 =?utf-8?B?cmtDZURxU2JzdkFUdG5Yc3lyelp0eVB6VmtSUHcwWXJEKzVpcHBwZ2pIZiti?=
 =?utf-8?B?VUJPQnM4eU1md3ordkdGbnpVZE5KR3JGK0RWYUY5YW5OWFZSend6U0l3dVNv?=
 =?utf-8?Q?ZpRawQ9Ros1ZY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b886ec1-2535-4a52-f32e-08d8b6beb309
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:55:43.6030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okhW8dsD6UiCZiG2DXIpD9a48U1oeWkDEbW8zY84K8lztJYu1UBh7uLx203QbJl/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2503
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Zhang, Jack (Jian) <Jack.Zhang1@amd.com> 
Sent: Tuesday, January 12, 2021 11:20 AM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: RE: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset

[AMD Official Use Only - Internal Distribution Only]

Ping...

-----Original Message-----
From: Zhang, Jack (Jian)
Sent: Friday, January 8, 2021 11:07 AM
To: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: RE: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset

Ping

-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com>
Sent: Thursday, January 7, 2021 6:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset

[Why]
When host trigger a whole gpu reset, guest will keep waiting till host finish reset. But there's a work queue in guest exchanging data between vf&pf which need to access frame buffer. During whole gpu reset, frame buffer is not accessable, and this causes the call trace.

[How]
After vf get reset notification from pf, stop data exchange.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 83ca5cbffe2c..3e212862cf5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -571,6 +571,7 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)  DRM_INFO("clean up the vf2pf work item\n");  flush_delayed_work(&adev->virt.vf2pf_work);
 cancel_delayed_work_sync(&adev->virt.vf2pf_work);
+adev->virt.vf2pf_update_interval_ms = 0;
 }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 7767ccca526b..3ee481557fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -255,6 +255,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)  if (!down_read_trylock(&adev->reset_sem))
 return;

+amdgpu_virt_fini_data_exchange(adev);
 atomic_set(&adev->in_gpu_reset, 1);

 do {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index dd5c1e6ce009..48e588d3c409 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -276,6 +276,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)  if (!down_read_trylock(&adev->reset_sem))
 return;

+amdgpu_virt_fini_data_exchange(adev);
 atomic_set(&adev->in_gpu_reset, 1);

 do {
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
