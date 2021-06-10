Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0344C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 03:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8688610A5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 03:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8688610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C33F26E44C;
	Thu, 10 Jun 2021 03:56:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B673E6E44B;
 Thu, 10 Jun 2021 03:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkAgm7VrRICROurcKPIASriCBLixhFnEjbCyQ1FlLwpN0E83UUqemN8ksyc3wgkprVxMiTDgJJEKoM12ltIv2eBpnuLQ9/asCPCG11+4+DSVHIshXmhTdLfU+6GI++i8UkAL8M/wAPq1M36cfXNeaWKDjvztKVYNAm7TUrb34HOQ/TYvfjxBq/J2h9+ONxPSDMU1a59kRWciF/fsRMuzQO1GnTOlWupYmxBq4pWwa+r3AiRSnjV+1HMgjBHOKYe8qSi5Zy8n38Yr9WMMa9yF35U83lfUZ3iZyr4gnFhOrTHhy13CW2PD5adT9iwsVUKAgy4ZF4eEbpxvnlKr3w1RRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IabpxjsoTbKoxCRHkmb26Y8S0LgUO/WpmFiQho/+6JM=;
 b=mXPz1W7/5FokdXSKmkDUfJLolxrpLLjOIZfYcfE9lqkOuoX7sXKp67bYf4tcDiCSymy8vUYuom3ShNmeh8RFH7QhEAberZd7FV8gHNWouU3lOeN0AH0aUcG09kjuPDgzqQa0cWds8AkqV7281F0MF4zz6JoUvJtMa0G9WEBwXc6FwRpd3/Yw9+4X6ckCCS87v8qJ6roNW+Bxs0lqMn3KdqIc6xuZm5WjVvyfQFDDTMEmfd98dGYhaFaQeoiAondeNB5UQ5sjhPyDndEAvYgcKSMQetOGfsiHkh8tl9wIcxO34XKPPwcMdHL4MChTm4eOMUzPhxRiKUqC8+g5dvk1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IabpxjsoTbKoxCRHkmb26Y8S0LgUO/WpmFiQho/+6JM=;
 b=NQNh61dSzXUz8pbvyue3r68NZwGRW1pzsqjvVv96icg/a/vkcy663Z9BlcWGGdTa/mZMN/j3OZbTALc/2rCv9JQm0254ITZz5RcmOpd94bOmrhjpVpcz2iB2pvL3mfr1YK67VrWGCWu+W5zuGbKT9/fhF/V4Lj9zjI8YlgKA3+M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3856.namprd12.prod.outlook.com (2603:10b6:208:168::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 03:56:47 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 03:56:47 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu, radeon drm-fixes-5.13
Date: Wed,  9 Jun 2021 23:56:31 -0400
Message-Id: <20210610035631.3943-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:208:23c::19) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:208:23c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 03:56:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68e00173-ef1b-4fbd-2c4b-08d92bc3c4d5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38563EBB3E78C2E6270729BCF7359@MN2PR12MB3856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByuUtsjTzPD82uUFV0NJddmoYezDsYEiJTLwAUm6+HHisf4WozWnZfWodyeJIF0n8CCAekXNj4NPvvyQ2mo5zIEG3PvWDP+imz/PoV925Or9Jr270KV+bu4pitPuxvPk6I63nCLWIGQCa6iCD5rsZEXiOtv0iBWeFJyJvwMART7Tkk6ocRwlc5/hKFKjLT9TTOpc2ylhyPzFt6vOBAzNXltFPLcP4AUU0GRBbiZZ3ifkjq5mR+tjI5P8seYo6m/BXoi/bu9/MG0gmU3MaUBzvY4xsrZ2ZHqMKDoSuBVV1mUcLI8kyMFmp/l10HYhEKNYZRy5jMf+uKWPBkw3DAcKwkvAPoWTpGgokCxMdsCCagpWY9HFKUL4B97yopL0kwmG49yu7zKTmzXMsdIqUCUqfQllvhzt9hGUfzztf+3X02em/ln7XzW5uHsuzOEgAi1+78Mui9+YetwGFmfV6is5NYSCjJh/QQH9NKmH+oREKEz0Cy/L9oMs2uFLpOC8rM3DbDdOFJ0g6CYRgwGdYbLU0vW+npth0FMKvrLjkovSxcLVbZLC5Vp0tuzTTbqwRn8VHSKAcfCCt7UUdzoo6O81D3el446eYNNimARKvJu6bmHzK9PgilDhuJPAZvjgrTSZ03Fny9hzRPP6QTWTdEmR6lD2jX384iADRb06jXig+MlUIiodW2ZbGbRwafnOdjYr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(66476007)(8936002)(66556008)(66946007)(478600001)(8676002)(83380400001)(6486002)(6512007)(6666004)(2616005)(956004)(5660300002)(52116002)(36756003)(6506007)(38100700002)(38350700002)(316002)(186003)(26005)(16526019)(966005)(4326008)(86362001)(1076003)(66574015)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZad2hUcnFNV0hYWDRyWEZKanJ6NzNlalJ3cTMwQjE0N1BxcXkrcDY4Z2FM?=
 =?utf-8?B?amRxN0puZEJ3NHB2anBuaXBtVWJ1WjYzUjhXZGgzdDQ5OXhZUEpMelV4SnQ2?=
 =?utf-8?B?eXZrQmFIM3FtRURBNDhHR3YxbmdtMG5iSDk1K0NQTE5QMDVLOHUrNzlZSEZu?=
 =?utf-8?B?WnYwa1pYa2JPMmRscHhUUWxNSEdXbi9KN3REVCsvTlIvYjRmbW9UbzV0cXAy?=
 =?utf-8?B?dk5NaDJHajBtL0lsSHRjV0Y5NUxYM0dqOFJYbXVTRmRjYitnYXR6TUROell1?=
 =?utf-8?B?a1puWEdYSDEzOE1GcjE5VU1uRmdrbEhkY09WUFU1NDlmVE4xN2ZKZ29UNzJi?=
 =?utf-8?B?eWxVdGNOYTFhQlNVRVg1MkRHam80R1dRMXpEUUswdnA5ZjhZT0lCc081TjVR?=
 =?utf-8?B?NGFOZ0w3bng3SUUyMjU2cEFNOEhEUE9JeVByZksrY1NsVytXTllQcUd5T1dj?=
 =?utf-8?B?TjQvek1CdlFzNXArNldyVlRSVlRQQ3VDVEo5RUhLeU5Sa082dk4rVzdGS0Nv?=
 =?utf-8?B?QWZEanZJWXQySEkxY0Jwa1JaM3FHVXZubG9jVzgrdDVVUThsb1NXQnQza1dF?=
 =?utf-8?B?dmhGVC8rV0JsT0ttbVBlR1gxY1pmNGRMTWg0VkIxREwvWkM1WFZ5VlkxTDRu?=
 =?utf-8?B?bTk4V1B0WUUxQmxpNTNNTEN3dHQwVVRwQ2JkTUw3bWVNcXdQWVY5V0o5aVUv?=
 =?utf-8?B?Q2JPdUxxUGl2cUFXangvSVJ4cy82Q1FSZ3dQK0s2WkgxZVRXTG1NdFVnQWdv?=
 =?utf-8?B?VHhldHpNUVNGR2VlbDBhQW1kODA1UW1pSkdPNjV6Q2N0R0p6Y2YxbFRZRU9n?=
 =?utf-8?B?YXIvV3Z3VTZUVWNFdlIxMkZBTWNpMnMxdnVod1NKZ2tKQVIzZnN6OHlJdjIy?=
 =?utf-8?B?V1J5SlZ0aW0zQXpRdjFRRENoOWJaZXBkZ1pCT2dOdDFoYkNtb3pTa1ZRNXgy?=
 =?utf-8?B?VVJod2xaS2o3S3VCSVQvOFdMeTRVc2xkeVJtQU1SNEtWR0Z1VE54b0FwTEJP?=
 =?utf-8?B?Yk9PcHEzaEUvWUlKVGlnak01bFZMLzBFajc4Qk1TdmkrOFB0RWRyUUd4QVdW?=
 =?utf-8?B?YUFPQVVmbm1kYTcxd1ErSGNoaU5QVzMxK3lIeVRqSWxSemcvYmc4RnpKWEs3?=
 =?utf-8?B?K1JUQitWRkhJYzgrdWFGaDg1UjZpNkVzUzdiQ1VZVUV2TFI4VG5sRjlMdUhF?=
 =?utf-8?B?Umw2Y2wwSG95Uy9Vc0hYaG1Ea0ZxR3dTb0hVSmVDUTB5T3hjUng4aWNTOStZ?=
 =?utf-8?B?TS9DbHJrdjdqb3RJdkpPdEUwMlkzWlJ2dXBsRDcrczZubTRrZTZkTGlMQVBw?=
 =?utf-8?B?eGNqbmtjMERVWU43S1ZLZnAwTzFlZ3BJY0ZGS3M5WkNlUFlHL0lRQ1lKc1lJ?=
 =?utf-8?B?ZXltQituSmVGcXVHUXRwbStPcm9vaUFYa2QyWU9xTXZkMFJkalhTVFYvcURu?=
 =?utf-8?B?Z0dtRHdQd005MzNCM0NFcXdQRlhVL3BKU0NsdDI0WmlGNkl4cE1Zd1dKQy9J?=
 =?utf-8?B?NWVOaWRLUXYvbmFBdThMcVdOOWxCb1Qxc3JwWTM1Z0I5T1hMZlYzNC9PMjRR?=
 =?utf-8?B?ajdJWitKbWdFZXNtNjA1YlVQV09wc1dqUUFMSGlLd1YxUlhmQkxNdnFoN1pu?=
 =?utf-8?B?a3p3dWRXZEhPTEFhQkhmR1VpeDhXV21OQjA2VkFRS0FzKzVsNEg5SEE3bFNj?=
 =?utf-8?B?V3Q3U1pwMHdUcCtqR3VmWSs3c3Zra2JKQnhsMW92Y1JiOVBmNEtvZ3lmZTZI?=
 =?utf-8?Q?tiKaLeHpsF+zIRXjjkEkbTYMo0E9uJkAZYd2uX2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e00173-ef1b-4fbd-2c4b-08d92bc3c4d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 03:56:47.2220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/5UPnScBvpFkxxvu8MDRoGswjOgGZjMuU1X6WxfduzuqXE1pMSXXgA4XNl/57vILmKVnUNJFgagIC7bbRV4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3856
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgRGF2ZSwgRGFuaWVsLAoKRml4ZXMgZm9yIDUuMTMuCgpUaGUgZm9sbG93aW5nIGNoYW5nZXMg
c2luY2UgY29tbWl0IDYxNDEyNGJlYTc3ZTQ1MmFhNmRmN2E4NzE0ZThiYzgyMGI0ODk5MjI6Cgog
IExpbnV4IDUuMTMtcmM1ICgyMDIxLTA2LTA2IDE1OjQ3OjI3IC0wNzAwKQoKYXJlIGF2YWlsYWJs
ZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9w
Lm9yZy9hZ2Q1Zi9saW51eC5naXQgdGFncy9hbWQtZHJtLWZpeGVzLTUuMTMtMjAyMS0wNi0wOQoK
Zm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGFiODM2M2QzODc1YTgzZjQ5MDFlYjFjYzAw
Y2U4YWZkMjRkZTZjODU6CgogIHJhZGVvbjogdXNlIG1lbWNweV90by9mcm9taW8gZm9yIFVWRCBm
dyB1cGxvYWQgKDIwMjEtMDYtMDggMTQ6MDU6MTEgLTA0MDApCgotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCmFtZC1kcm0tZml4
ZXMtNS4xMy0yMDIxLTA2LTA5OgoKYW1kZ3B1OgotIFVzZSBrdnptYWxsb2MgaW4gYW1kZ3VfYm9f
Y3JlYXRlCi0gVXNlIGRybV9kYmdfa21zIGZvciByZXBvcnRpbmcgZmFpbHVyZSB0byBnZXQgYSBH
RU0gRkIKLSBGaXggc29tZSByZWdpc3RlciBvZmZzZXRzIGZvciBTaWVubmEgQ2ljaGxpZAotIEZp
eCBmYWxsLXRocm91Z2ggd2FybmluZwoKcmFkZW9uOgotIG1lbWNweV90by9mcm9tX2lvIGZpeGVz
CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkNoYW5nZmVuZyAoMSk6CiAgICAgIGRybS9hbWRncHU6IHN3aXRjaCBremFsbG9j
IHRvIGt2emFsbG9jIGluIGFtZGdwdV9ib19jcmVhdGUKCkNoZW4gTGkgKDEpOgogICAgICByYWRl
b246IHVzZSBtZW1jcHlfdG8vZnJvbWlvIGZvciBVVkQgZncgdXBsb2FkCgpHdXN0YXZvIEEuIFIu
IFNpbHZhICgxKToKICAgICAgZHJtL2FtZC9wbTogRml4IGZhbGwtdGhyb3VnaCB3YXJuaW5nIGZv
ciBDbGFuZwoKTWljaGVsIETDpG56ZXIgKDEpOgogICAgICBkcm0vYW1kZ3B1OiBVc2UgZHJtX2Ri
Z19rbXMgZm9yIHJlcG9ydGluZyBmYWlsdXJlIHRvIGdldCBhIEdFTSBGQgoKUm9oaXQgS2hhaXJl
ICgxKToKICAgICAgZHJtL2FtZGdwdTogRml4IGluY29ycmVjdCByZWdpc3RlciBvZmZzZXRzIGZv
ciBTaWVubmEgQ2ljaGxpZAoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNw
bGF5LmMgICAgICAgIHwgIDQgKystLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jICAgICAgICAgfCAgNCArKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEwXzAuYyAgICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrLS0tLS0KIC4uLi9n
cHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYyAgIHwgIDEgKwogZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMgICAgICAgICAgICAgICAgfCAgNCArKy0t
CiA1IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
