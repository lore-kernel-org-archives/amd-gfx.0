Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED8FC433FE
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Oct 2022 09:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E88F10E1FB;
	Sat,  8 Oct 2022 09:13:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6B610E1FB
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Oct 2022 09:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUfVrcseSGIjfCKlWCBvGMfxwQJmlSylGXguXpCMBCywSQfOLqPobtkzt+uekOM2MKpOwzBs5YIZ/DYmxMs/Ia0FYc0YEqlrrVF4teirpU+B+YoIt/XkcNq6tGU1kpIUMp7mFVx2g0HqhOBuTzJLvwBtXtqJrlIXBbAMNXQ+2MbQauSYky+Pw0v2oqqmxdG5RB9N8Lv7lQqQMh6rLJaq5JYxftigXEMUItcU2EJmaDIfock8noFCARNibXW22HxIQ7+P8OPptlDf3CGAnyycnR0GGZxLZSxAsFHCHw1UdJ+FSDwgQVaS4+jdYBlO7VjqHb5Nt52EnheYc3IfKeV5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlUZVxMLPVebK9wJq5O/n9N8zKu3EF+IjO/xTPv6ucA=;
 b=Y2SpLCF1SRnJtuLbo8zYLHoGDh/TGkSwYWB0yU3FR+Z2aHoTgznUwGz+k0VtRxVMSil4HP0xwG4tlWmHsdyKk129k6xcgdVrCM7vhpNom7tlh1FJtXCXW98N0wOLVvJ+7IHT+KMjN5OfiOsqydNxkHdVGfMXY9HJxr37UVcd0rfJMCoGYgv+kmx4ot0lAW4DqTVBbf1WEaw7u1MN9kQL6NciGcNWrDZ745YieKSvVmEqOmIDTpdEyaudC94nCzDkXsi1CzG/tg9RYfMNdZo1qmFtHB30/WY9QFLfqw0BeCZTkZ0CIBzlIvdw3fN2oDjXhM1zNBA0IAp+9vlq0Ockfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlUZVxMLPVebK9wJq5O/n9N8zKu3EF+IjO/xTPv6ucA=;
 b=RVW63OVVmjGRh3lJrwpXOAeBTvFxCvjhP1gaVtulRkh5UeZImEMEvVqd79n411NzXbgGK7XwY4B0KWyTfG8PjrO7FxCqt9Z1RXUN4X21nNj33rYYt8QVEqFhsW9kbmRfTH21Wncu1Ad4Of4tVR+8PpOxBGav07PYH6DVzuYNTms=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Sat, 8 Oct
 2022 09:13:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e87d:8092:3616:9a44]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e87d:8092:3616:9a44%6]) with mapi id 15.20.5676.038; Sat, 8 Oct 2022
 09:13:41 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: smu7_hwmgr: fix potential off-by-one
 overflow in 'performance_levels'
Thread-Topic: [PATCH 2/2] drm/amd/pm: smu7_hwmgr: fix potential off-by-one
 overflow in 'performance_levels'
Thread-Index: AQHY1/LQwgPhmb3E30Cq/onRkuUmkq4EPHpA
Date: Sat, 8 Oct 2022 09:13:41 +0000
Message-ID: <DM6PR12MB26196DC660A86E363EC4ECD8E45E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221004081402.49069-1-aleksei.kodanev@bell-sw.com>
 <20221004081402.49069-2-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20221004081402.49069-2-aleksei.kodanev@bell-sw.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|PH8PR12MB7205:EE_
x-ms-office365-filtering-correlation-id: 818290ba-3535-4cb1-9aa5-08daa90d64f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m0voZf2JvMr1sMdX3ucatk7J3nW9clrj94amgF7qsUTBUxwUhg/iKuPwdrgfhrykNKNw3807pffokYuwcphKchmPJYdnnDYK8LIJYUOYJlAWAttyoYp4Sc4f3Z2vgU9/auih+IYNprqWg15Kv2Tfag1iWEFt6/GBh5u+mn4ih2XKzHLBa8DlE6Rpu4h7LrufNxq1VsqpBnb58LD75d8dHTmyRYEVE1WYCP0IsdOBw50tHZs5EKf2YAmiEQvWmyCILr5IZ45voRl88+jy2GJM6z7MH1MGMQgmZUpP0C/k1uvnEyUc65jXbHkapvVUhmWg0J0lggRvcLb5hP6I69FrQh5NLAIDQVQd9KO1zc2WST1S7GQBNE+U908S9rPuxTqapbRTtVRq33fdS2vhxjhd7gX2vyHLOvLrD/F2dHXMFI+1oBdS7g8OEAh/LEc+1ihEis0lRVAu67R9luXSJJeMq9IfVFzExeMD4NF+jUNOhukF1kGn8NojxXr6GmNnvHCpXTCQoIpsjBvCtDNHaPno8Uyq0nJ0/Jw9LXLVr0UdaceGLdeE0paJSYNR/d9+xsmPeRFkFEL2a6suXx8Fx0RqxdRN/yQI1VFYHvdqUdhwLotEsm1FVpaIhrpO+nSCeAGipW50euxt75uG301eKj6H+Ixlgud01h2Uc3R5cZDifSSVnNFpL6njtmOJLG0NCuiSaQaeSTkQzc49qGe60Z85mMko86Lcq21mQTGb+bsP962RHeb4Dwv2+5XQA1iJ/+JvIQQKHfTHghjie3Hbp7pmoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(186003)(53546011)(478600001)(71200400001)(110136005)(83380400001)(8676002)(9686003)(7696005)(33656002)(41300700001)(6506007)(66446008)(66476007)(8936002)(66556008)(66946007)(64756008)(76116006)(52536014)(38070700005)(26005)(5660300002)(86362001)(2906002)(316002)(55016003)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Usna9C34jqtqCuoicUMtAA668x0DHyatU64i1eEM1siXGGPXMb3T5KY5g33F?=
 =?us-ascii?Q?MXosy5EyvCtHIErhL91xbjfkLAgnDGHiTp7Hm5JdFIBMxF3PuhDjq+ZQICr5?=
 =?us-ascii?Q?jLrHwStrlagDAoWpoM5cg7OseF3/H/YR7I/SGO45f2uxp3mMhK9b69gn2DK3?=
 =?us-ascii?Q?n/fNUNPnKXm/OqLV/bP0KvJblfLBLiDjyN9ubJlrnN4Yy+G/ul64ScCZixWz?=
 =?us-ascii?Q?qtPtCq41z6zVKGmnOGUb1yHuSFGcZPYBbsehq89erl+rzW49jOeZ97lPfz2t?=
 =?us-ascii?Q?ypqBBtbDQP8BaE9q3Hhoru0AXn3uveJUUGoHLah0hzEw15OgWDQyahiv6t+a?=
 =?us-ascii?Q?F7vjkFDPnVBatZzYjcwitN0MDNJmjJqwuGa7k9PBr0H0roSUaVjdjL/96lLW?=
 =?us-ascii?Q?ZO49LoqodJYa3L4gnSam0PtptkdF0FVUTDXr9IBB/sxbZnY5tw3m8XbGsX3E?=
 =?us-ascii?Q?PH6pVAs1N1oa/ipETsK5yX080xcR/BCcxqdUHFOD1lorZwbeednxcuGC9FgM?=
 =?us-ascii?Q?arJ7itY5vqM9aaEO2ymFsAu3VLqn5cv81Sz/nR0O6QgvzWFJGtVv/a+a0Gg6?=
 =?us-ascii?Q?49IR5QIEqLSIws8SpcaG+zVFa0Jaq/DAMajhqi0Xh2HNcgeqA3/LLlBcDGQv?=
 =?us-ascii?Q?jFdLQss3fERKNgquYi7yb96ZPFoJov2/WoiAuZqYUgvhcXI+XCsW6oTajDR9?=
 =?us-ascii?Q?wQG3K7aZXeBk6CAXNhzK2xk8rSnpUHjvM77XKYVLHJ5ALkoEpQGZ1T6WlEwO?=
 =?us-ascii?Q?szIb6EZsjC48TItIzERzSJiMjE9zDVrpUXQLn5R3H+pev7DYMg2MF0AvWBQz?=
 =?us-ascii?Q?6lnF4yUuG/UEass955Egcpfg7cBojzs2fb3mNClB7ZxDLlh17aTHd3ibgdbG?=
 =?us-ascii?Q?RYOpoNZAafUUjqyddk/T8TSYAnGM3Ku5/Xq1LngMgRBHGFTHBzw6bq9ijWrD?=
 =?us-ascii?Q?LjhwSYP/lLf07UojJHF93XmWQkg4HjI80fuxe2cEJM5FjE6i4J2KOcxt1v6R?=
 =?us-ascii?Q?GxQj/VKKdYQr3Yjfr9olPSQl0s8XVwOU798CRCcfLBmhnZ67rsYWLt6i0UI9?=
 =?us-ascii?Q?RmpXtlVQ8zFw92AcDeczmybm+IF2nNO+j7JIWGVME5UE2EmP82xDUkp4MRQE?=
 =?us-ascii?Q?/p5EjAtDymLN+YZykLSE+stLDDSQ4XxAoAnT4maw7jlcbp85vlWtRXbh7hE5?=
 =?us-ascii?Q?+JF24JYT71LansCGw8fPUAbKOdJQdpXryZ2B/2HMwjcG3KNpv1CoYzJbmFK4?=
 =?us-ascii?Q?YULV8CLuIK0thyAYHHfBscBq8/sAdafML3DvT7ZzdtPTPzeexXPQ6mIQ4MSj?=
 =?us-ascii?Q?Zd6JD+syG51rgibn6A231X9I+J75KiZVtkdODmhktTDwdRzmh1MLXd2E1E7j?=
 =?us-ascii?Q?OYmhlkV3/DQoe8Uwn01dFxk+Gy5aRo6NRfCe/x/LFsbkO5j4p3FsxQwYCqw3?=
 =?us-ascii?Q?zV/lE6Ww99Kl2ISC3jYdhoRDk1PF9mcG1OtBi9w7r/7zqvTcX75/2469H9rD?=
 =?us-ascii?Q?l0ItSLO45JJpLW3a/ieH6KX/hFbWHyvuHYPjbF+Zwajppzn9H+UXOsWa1KGs?=
 =?us-ascii?Q?HbnXjFjMWpdyOLKP+vY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818290ba-3535-4cb1-9aa5-08daa90d64f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 09:13:41.9076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2N9lav8YMF4vB5ZA0Z3uevXTjvpuqz4iY4Zupq7oHGxgy0/udQoT21qp4692h+Yg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Alexey Kodanev
> Sent: Tuesday, October 4, 2022 4:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> Subject: [PATCH 2/2] drm/amd/pm: smu7_hwmgr: fix potential off-by-one
> overflow in 'performance_levels'
>=20
> Since 'hardwareActivityPerformanceLevels' is set to the size of the
> 'performance_levels' array in smu7_hwmgr_backend_init(), using the '<=3D'
> assertion to check for the next index value is incorrect.
> Replace it with '<'.
>=20
> Detected using the static analysis tool - Svace.
> Fixes: 599a7e9fe1b6 ("drm/amd/powerplay: implement smu7 hwmgr to
> manager asics with smu ip version 7.")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index e4fcbf8a7eb5..7ef7e81525a3 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -3603,7 +3603,7 @@ static int
> smu7_get_pp_table_entry_callback_func_v1(struct pp_hwmgr *hwmgr,
>  			return -EINVAL);
>=20
>  	PP_ASSERT_WITH_CODE(
> -			(smu7_power_state->performance_level_count <=3D
> +			(smu7_power_state->performance_level_count <
>  					hwmgr-
> >platform_descriptor.hardwareActivityPerformanceLevels),
>  			"Performance levels exceeds Driver limit!",
>  			return -EINVAL);
> --
> 2.25.1

