Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1ADC433B4
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460C961139
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460C961139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36DD6ECDB;
	Sun, 25 Apr 2021 07:31:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85A16ECDB
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfL+yQJz/1XEVsDOjfPAdzurxTtr0cMw7miGV0583DPsC6NgxfRs59pZi85PfHcQh4egXSOzoJUiqLA5MbvgepG8+zJDJcMg1oxij27nOZZx7eVwOs6lSnmzAlkzqwts4N28iDz76MvH310bUYUnAbtf05XPc5IevUFURhyRkhr70KZ7CO+FeT/ssg7ZkvJV5sd91leUUCv6+FGGpu9ewZDpI75vH/O5wwxhLcTM6AucHsRuBQJDHNmGuOBf4OTyaHhec3lgcaLfGO9pNGb+daT+gTpuBPMqDTovG5PqQKH+TzNf1yUm82nLIC1u2ZhsewfOiJC0tSjZROfePLRPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgjm54k5SMj6DJdFSESc8j6HVjQk9gutghYJ828MBoU=;
 b=IOSIl7WRERB/WZjsPPbGpJQH9gvz21zazczBMM+9efRWgso/vVveYJWlJdaZpr9fwHhpTX9fOcIVo+hqDAX/nux9mNPUZUrs8GAw1qhFvjUI7aoCPtfJ8UEvNx0mM8qUNqKZckJlxBiEg3TzVald11k2ODBpuG7T9+1HMi2ZutmW+5J+8yzJWHyVYuC64adpDW9RkYuyVVsb7LnAFKqoGyDMxbhuIIadiUB16euWV5vkKmEC1tNKmBPtQOn0E1XjSZRmb7sb5S6dcnyZz8d/kMjwAe49VNKFNH58TB99qo7QaSZ2qCR0yBr27e2fgVbSXK6ugjUtZFAD67Z2yCMoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgjm54k5SMj6DJdFSESc8j6HVjQk9gutghYJ828MBoU=;
 b=zOx6fmmvB3MmH/vvDYrlf+pz97HIfezCPqUCeU1xH+9axh0CJtL7EKxL5I4tUFPapUZxccYt0xNDHIiecAT5A0vqXXH1jYOqKfQfV2Ll0H1+Mv+YQT9ms9tYoWmW0uIrCQk9Wngw0xxeihyg00fMu9jn1GoS0fLjfWr6rx83/n4=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com (10.172.77.147) by
 CY4PR12MB1368.namprd12.prod.outlook.com (10.168.169.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Sun, 25 Apr 2021 07:31:12 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f%3]) with mapi id 15.20.4065.025; Sun, 25 Apr 2021
 07:31:12 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove unnecessary header include
Thread-Topic: [PATCH] drm/amdgpu: remove unnecessary header include
Thread-Index: AQHXOaILNl20rT2ys0uS7izEr7X616rE1qCg
Date: Sun, 25 Apr 2021 07:31:12 +0000
Message-ID: <CY4PR1201MB00720D9030E207DC0DC98FE0FB439@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <1619334603-8305-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619334603-8305-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-25T07:31:08Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6ebefbc7-06e9-45ea-af67-8c98d8e7875f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3c508ce-be1f-4371-753b-08d907bc1a64
x-ms-traffictypediagnostic: CY4PR12MB1368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1368F64BA2425BFA7691A8A6FB439@CY4PR12MB1368.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6LePgRVgf0S738j+amMf0SIqfOmTAmykR8BIes6M2xWoGAg7CNIiLWU1C2ProAqG22DlDOKBbrlXPBSnD/Pohs2a5JFSfF7aBQ8ru/IQc0N8Cr2PYPBBrfmYbJ2JFp2YOnG/i51LMRyoid4v3Bw/1RKq6kUQqtcwAAe52Kkfs50StGhDyXpw7hLVcpQhEi2/ucRhRNrsLN/LmIK7Bh3kjknyBHdx3GeUpPlZrR5FkQtLRWxRI+oQ1THi9HNhuuMuvpN2g6wGWeoYznt/cWePqd38bEUIMC38kUO/kYOkjKOSNB/L5VkOmwOCDJHJaurVgAwzf/PU0AVNdSMX0SuzjBhW7Z/k/h95acJSFgxcxWa3hS0VdFcUyIlIl/lVHT9OHvINwxm9fhDGsXGfX02fjOFYs06WVbqSsFZ1VIhJXv5kx3iV3J9jgMweaZQ8DxdTo8uNeB82JqnnzfFE8u2bdE5W23sq/ga4MGujf0pNHWHLF6bNY4SFceJpxaTbSBEQ3s+ifBTuJIM/9KnCxiJTcYuNZvNU1mnTqq3IRc2lTLfm4L0WUzkCSJ97o9tV4TY0wf/ssM8U0NYuNWCKdF5o4ZVSYeW3Z4Pdk5LN9PuZf06g+K0Hy3Ws+hjwp3jPy9FH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(45080400002)(8676002)(8936002)(6506007)(6636002)(316002)(33656002)(9686003)(55016002)(66476007)(71200400001)(66446008)(52536014)(7696005)(478600001)(76116006)(66556008)(966005)(66946007)(53546011)(122000001)(64756008)(5660300002)(186003)(110136005)(38100700002)(4326008)(83380400001)(86362001)(2906002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GeM9sGm48C+LIWIcmbrsLJK1vLUwtOtmxGlGu4+yDsP8472UT+t/GzXz429W?=
 =?us-ascii?Q?pjZXZhkXvPw0GkSxZGH3TLgHcdgNEmKetKykbBW5AVeb/CC8d5v+dWqCYXKq?=
 =?us-ascii?Q?WjYrQA5f3hTiW63MKl01XYJUsxmIOPMktxfy2QZfpVfErSByos0WEj4VvRVR?=
 =?us-ascii?Q?k32cF8VH2ektOEQFJg5HJkrN/lNquE4CtFEQZ3or6HcAZkWmTxF8ZuysWdRM?=
 =?us-ascii?Q?bqdTuG/ANF4oYCbjnu131BQOxt8f4KDcGFULwdkJFtsvY+Nir0m/tmGQhoca?=
 =?us-ascii?Q?0UFJHz8xtE6bxAA6+CHgW1h/ebauycnMTU1iujaMjGB8z5wh9zb+5RpuPlH1?=
 =?us-ascii?Q?5W0zNKObvFmoLNzdxkCAVpqN+7B0v1TzEhkKkn2nxalpg1+xEB0RVnhx9Auh?=
 =?us-ascii?Q?PXB8OS+7VGL4QXJugwdVv4WslKaWnYoTmT2/O74hpvHaO41O3Lb7Zu+W+m/b?=
 =?us-ascii?Q?BBgnAO1u0ZTnup4Adx6O/abmqJoum4AEnV3lI4NmhN046vlIboOMymDEV6kq?=
 =?us-ascii?Q?qv38rEhuOeQGEd1He/AtIAuCiI8aMC6w8oDx2gpotTSrB/kSrf4s/mg8WBYo?=
 =?us-ascii?Q?swf30iUg+3NAnu09QkQJtsHz5LPLaQP9Dgh7SONfxj47xXNGaeVyuyBQyoqZ?=
 =?us-ascii?Q?Ti38FgAe1nFlzO1J+EHQco42VoIOqRUerosbym88KFba9Ltf1uBDOkJk2am8?=
 =?us-ascii?Q?t0keFHcdAHjBmA57pab/iZ4oGbh3P++WeDmTx9BDbt4DJMOhtsjgN7NvxJ+5?=
 =?us-ascii?Q?trV0Z5LkDT4Yw7hsQ3umRD0vNwNpt1vzTWf7riWU6FfKasrcTYSg97xW4Txi?=
 =?us-ascii?Q?W3q/3OlkhuxNyNna2Qhcp0fLTGeWvF7olBkzhfufECOwbcaVWeA8tWmH8CI/?=
 =?us-ascii?Q?OuYFmQWm3tz2ASmR3BKFtTY8QXVXqXuWaqbXfvYi3m8dv1nzWRdtKjXSvdyk?=
 =?us-ascii?Q?QZvfLQatvxIkI65XSzv+nZ3YEiNsv31Nws9iaNXAVxxNN7jLL+RW/wvurwu/?=
 =?us-ascii?Q?ZLNOxmWnc33J/NgHEWr61F8AE2fvWPwNW/SqsL8tR+n5pXvi2hsZvytey/Xt?=
 =?us-ascii?Q?6HG02TRHYqkXmfcnmIGyWjMsQYEmSj9NHfw6ECzHrW2VM2UAF5SzGF0vutgj?=
 =?us-ascii?Q?F9/rkqYebzTTV3vBRIDwlKKjnVkWOvxBymSGAZxwyenJWhynKaeYKgL2m+9m?=
 =?us-ascii?Q?GfBI8H4hvQHVMceyHn79CgPGqxkNfa/qwOnc+3bmmJJLeWDzvCwgm0E9cJoI?=
 =?us-ascii?Q?8FE5pobmF5alYkOprJ9cyqmYe+EzEHMsCRsL5cIYC+EuxURSa6+CZIihgW9s?=
 =?us-ascii?Q?TX5jCS8boecuj+AWwB7+Xt7r?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c508ce-be1f-4371-753b-08d907bc1a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 07:31:12.6263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrSv96Dyx7YgsvrtT1U9b6/SBWsN1RS4/du6i6RbZOppxL62kg9R7OqOMU8UYQu+ymSYGjjf5CI/DBm9e9rGeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1368
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements <John.Clements@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking Zhang
Sent: Sunday, April 25, 2021 3:10 PM
To: amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: remove unnecessary header include

amdgpu.h is included in kfd_priv.h

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 696944f..97c36e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -25,7 +25,6 @@
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_smi_events.h"
-#include "amdgpu.h"
 
 enum SQ_INTERRUPT_WORD_ENCODING {
 	SQ_INTERRUPT_WORD_ENCODING_AUTO = 0x0,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cjohn.clements%40amd.com%7C8e3cbd2453e5496bf3a608d907b92c6e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637549314164877426%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3P9NOgVlpRV7jow1WgyaVIrapt9AkfOJFXeWE4fCyfA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
