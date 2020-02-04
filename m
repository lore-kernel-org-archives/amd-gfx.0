Return-Path: <SRS0=NM/7=3Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821B1C2D0B1
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 14:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F19120661
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 14:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UmjkPymR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F19120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046056EF2A;
	Tue,  4 Feb 2020 14:07:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00046EF2A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2020 14:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4miukbq2aavPAk4bNiSqHtXmuPqzMIiLDuaxCwX6fanHBioL/+40K2mWpHnfTLN7MQ2o/VhqFY5qnL2xD8rH0GHF6pPws5CW9Fs4oVB5xlJYcm7+tYYGlsJOUR/5QhqPg6I7cIuKHQ0AzChK1q2hzBLzPVWD5m7aKYnRcAbnMltmJtfR7xM6DWZ/b5+LDo1BU+Wrzwv2r+RYPNDYVs3bL2VtokJ3cGw7fz6EUBnldjFcZ5ukM1E/UUh956A9DCYSijAh+G645/EVyhq5Be7rAkjWyD+698Xb2ID20lZjbtTHaLkVt7AsC6+bdlWPWzrlLzi6/I6Sf0ly11Fk9pKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6mhORH9EgO1E/GQnl6HLSFJhhYZcjXIF8uvk50UeTc=;
 b=e5EGB5qPRL4lKN2K2HDiQUJBTtU5X81tMGCNpZIk/I++cU/GePKA5IVceqGpOCK3vhKsDthpPqQKk6+vnmlbdKkETDPLNvG5HIoZq4qUtIODU9pfPMOtqPz51nz+u3nqb5CThkql098OpGJbk+vS3OVXuU5DdsghLMG/WYZStKRICoxZwFKU+JdeZGPNq0CTcIozzuuQ3UZ23VWmc65XiR16Rd/SKLBnAA0QWrOv5kQIiOUIbYQnN0rgCZc+w3vCGhvUf67xU1YOEWLuqrqo6/vQk3oxYqAq1ZwSHtktaCFprCMhuB0xfaZxnEBg/uQfd0j6H6Rvpbf23HGqYcuSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6mhORH9EgO1E/GQnl6HLSFJhhYZcjXIF8uvk50UeTc=;
 b=UmjkPymRKiYqgkC/uwmiI37Yvx5FFA9Y95R4JaNCAfFAsLQz/nAW91JRae651tHofX9F2deUzWaG4VWVUq0SKsLvxYN85n77igwQTZpcrzra2Ek5jBM1S5PVkfmLiQmCmIH6os5PBnDAwr0KgfiYiCAqhCrKi7dsBp/284lk3OI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB2664.namprd12.prod.outlook.com (20.176.255.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34; Tue, 4 Feb 2020 14:06:58 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5f8:d155:b213:ef50]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5f8:d155:b213:ef50%3]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 14:06:57 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix logic inversion in
 program_timing_sync()
To: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Wenjing Liu <Wenjing.Liu@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>
References: <20200110201110.117166-1-alexander.deucher@amd.com>
 <CADnq5_PqWGUjn06jvxXfr=qQa45WJCK1aKgJ-b+VJRkVj9z4Yg@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <07041392-d18f-821e-4271-c94008818399@amd.com>
Date: Tue, 4 Feb 2020 09:06:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <CADnq5_PqWGUjn06jvxXfr=qQa45WJCK1aKgJ-b+VJRkVj9z4Yg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
Received: from [172.29.1.94] (165.204.55.250) by
 YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Tue, 4 Feb 2020 14:06:56 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d96124c-551b-47e6-904b-08d7a97b7f12
X-MS-TrafficTypeDiagnostic: BYAPR12MB2664:|BYAPR12MB2664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2664A8E9330851D973FAA59CEC030@BYAPR12MB2664.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(81156014)(8676002)(81166006)(6486002)(8936002)(36756003)(956004)(53546011)(26005)(4326008)(6636002)(2616005)(186003)(16526019)(2906002)(316002)(16576012)(5660300002)(52116002)(6666004)(31686004)(31696002)(478600001)(110136005)(66476007)(966005)(66946007)(66556008)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2664;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdJDYrFgy/p/a2q12/tV1noETz28mCD9FWdCfpL5kP6ijBg7x0RgET0RLBS1fT5LAibB948FWILvXyOkH+Gg9Yzayo/vSczizoTvs/PIcEh/k5pdeD/XFjzqAPrwtA0a2vd7RH1/Ayc3HXnB2RBJZJE0bk6qbpUfyf8F1S4UnaDmCcEz4Ey2zunXgqbwLb0he5XpQkaw12Yfg7A3tig1mP3CNhMph9upS0tO8Jzpk5Zk0w/wNe5z2ESUQWuNBu9gRKgH51PQcQLKntCZbVgNc1VnMJVeklk67t55UAVGKyucL/gVmtwehqhFCMqjNM+3qY31aP5n3jK4i75LCH8YV6NPuq7Clz/A4iaj7eUItboxJWSuiLe8V6Q+omxqFTQoLEX6R7MvYGXJG4tQlTt2DhqWFe+dIW6qWSl4tw4WvZ772CeNShQDggkhTN8JyCWQLzQ3UuXDrwYKNrR6Mfvo6/L7wQRdMpK2JvSLQSdEj+9Mup8H/v/i+kiur+7y/HBP3E3evKWu/XdJkw28/NQIzQ==
X-MS-Exchange-AntiSpam-MessageData: lpuH900TTV/LbL2E1r9gd/+uFO6Snvl7xdsdOQTEyK5W2J33wsmBOywJks1QhVkY/gFIOyLQhmjqq/c07Wod0iJBt61iMgEhOb3/fW7POzZuENzK6x57eqDPGLZDM5yUBUwnE6Z8zI+zOkTBg2itRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d96124c-551b-47e6-904b-08d7a97b7f12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 14:06:57.6937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8Wj7LNCR9CfXngK8mtEJZAxLs41yInCppxjvEHjX13q49J5iWvLlbs1Se1sC6jFBBM/y3kjHvQV/82DEE5uUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2664
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

Comments inline.

On 2020-02-03 4:07 p.m., Alex Deucher wrote:
> Ping?
> 
> On Fri, Jan 10, 2020 at 3:11 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> It looks like we should be reducing the group size when we don't
>> have a plane rather than when we do.
>>
>> Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
>> Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index 3d89904003f0..01b27726d9c5 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -1003,9 +1003,9 @@ static void program_timing_sync(
>>                                  status->timing_sync_info.master = false;
>>
>>                  }
>> -               /* remove any other pipes with plane as they have already been synced */
>> +               /* remove any other pipes without plane as they have already been synced */

This took a while to wrap my head around but I think I understand what 
this was originally trying to do.

The original logic seems to have been checking for blanked streams and 
trying to remove anything that was blanked from the group to try and 
avoid having to enable timing synchronization.

However, the logic for blanked is *not* the same as having a 
plane_state. Technically you can drive an OTG without anything connected 
in the front end and it'll just draw out the back color - which is 
distinct from having the OTG be blanked.

The problem is really this iteration below:

>>                  for (j = j + 1; j < group_size; j++) {

There could still be pipes in here (depending on the ordering) that have 
planes and could be synchronized with the master OTG. I think starting 
at j + 1 is a mistake for this logic as well.

I wonder if we can just drop this loop altogether. If we add planes or 
unblank the OTG later then we'll still want the synchronization.

Dymtro, Wenjing - feel free to correct my understanding if I'm mistaken 
about this.

Regards,
Nicholas Kazlauskas

>> -                       if (pipe_set[j]->plane_state) {
>> +                       if (!pipe_set[j]->plane_state) {
>>                                  group_size--;
>>                                  pipe_set[j] = pipe_set[group_size];
>>                                  j--;
>> --
>> 2.24.1
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
