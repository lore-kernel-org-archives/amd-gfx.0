Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B95C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 01:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D22F10F47F;
	Thu, 20 Jan 2022 01:38:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3421210F47F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 01:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7Hp985m6u2Vps3bLjRzuDOdZkj85wA9iZAEglEVvexkutUJd1KPJS0sQQCbjoByHw5TWhpEl4UROsPVf7bkGH6bY4X6zD3+BOiOxtiDbigO6vWalX+8dO1xgBlF3YmDMZL+7i9c5WnosKdBM5hKuUtdZ+pUp5E7da9W5So8Ul7embY4I5aIo9zdjLDuYCzoUetb8k1yMiZYj/Z/5qNtwEHp0YW3RZvz+lik4AfB8o1ic3BOUnpgLEWS8g9uJhyF1uSR3O5k1y9K/3IVKMuxZDW0FRJrlPrcLONhUnJdTPnSzizuHCfumWCZTTfzouqBgEYPHkmyV+KWVijrZlt/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrrhSVPFDvm643F7pvQ729AHdss8lI+KatUIEvHNokA=;
 b=LlpdYWcIFjwMDta+89qt2zGNcPHmV6RV9ErWgOp3nJpb+OJ1m3K1rgcdZ74Jxq1DyXOLTneq8cFJS3S6aUUOWLuYejDvFZLIznWFG8ZDXc9eDeCsz0WZ44/N/yMCQuc7UaeYbxB8vk2mQWbB+0FHRW/ZOkRdbC+7NAtd+2vR6jlqVXCW3nVqQQti3xpQl7jUds8Dn0oWmpRvP8WZu7sChZO06Kt1kAPS0H8/3nvqh5AdvMEEgxACnafY2cu/6AwAVqV/TNE9njcJTg9QI9bcgjnQPJTRMCDf0M8NNlbzQdYLCSd1H0Uhvdo5yRDhTH/uB0o+9lYLpOj9szDdhO2oaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrrhSVPFDvm643F7pvQ729AHdss8lI+KatUIEvHNokA=;
 b=PpT28S8y5lGlsAtWYwvi9xSe9pZdNiBXxDbhb+6VDfY+BcVN2TW3iOF1Sg7H2Q7EI6LF0Xf8K+PZDBOkNkmHmizF2ZgqiR6BD6GGztkDBsBuKKtRNP81C9GM4h9jyKVCTKUnjf03tb+3rzPfal1fupGf3dLE6h1lTo968Uzht8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23)
 by BY5PR12MB3892.namprd12.prod.outlook.com (2603:10b6:a03:1a2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 01:38:35 +0000
Received: from BN6PR12MB1620.namprd12.prod.outlook.com
 ([fe80::c5cb:c80d:cc1c:d768]) by BN6PR12MB1620.namprd12.prod.outlook.com
 ([fe80::c5cb:c80d:cc1c:d768%9]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 01:38:35 +0000
Message-ID: <0b2d87d4-329f-2e54-2db8-a12daf91180b@amd.com>
Date: Thu, 20 Jan 2022 09:38:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] amd/amdkfd:Fix the return value in
 kfd_process_queue_manager
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220119125721.278221-1-majun@amd.com>
 <BL1PR12MB514415F9B1DAB5370CC2952FF7599@BL1PR12MB5144.namprd12.prod.outlook.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <BL1PR12MB514415F9B1DAB5370CC2952FF7599@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To BN6PR12MB1620.namprd12.prod.outlook.com
 (2603:10b6:405:10::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41bc182e-dd46-407f-ca60-08d9dbb592e5
X-MS-TrafficTypeDiagnostic: BY5PR12MB3892:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3892398F794E72B2145CD5A4BC5A9@BY5PR12MB3892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRPqrE1BCweE0cbAQwFaaQLu/17tdVlIBhAYbOr4qlmD9J0Ak8vjogg62WVOum9qWAjsuI7c8/AoaBZprgGfYL/HV5CviDikon42GQuGSmNxoUmGrELHKdvSQ5AB5twhUNXa4s0QjMB0QiIqtmo0Vq3HC6Md6bRGkiR4UE0Z3m9/1oWhrIoalvRCAcSyPjEy55UWkDtKlNcVRuK0PtJuUn2H3Ew5/mL0AE4FWif1NRRfSW7d+D/h2/CzJ6TsVNdVJAAPv0T4USj+7WDLYxhjACd/jWXh3a/IO1ELaMhBb8br8CfWsXLWZBq3/bO8Ol560LMT8Ny1DCkLp6AknFNbDnXIVifhw97vfhhthpucm4X4OGPa4ddiYSwvc4VOJqWoMOjBdEwstAxVtzt8vWkf4NXCvEGjweVkMHWB5QivnDPgLR3e3gkhunLixUnj9qUTq3+3gISX7lY1LNYAkP3o/Ddgu5Q7/i8CxDUf2oYBjjzRFFG+8ZPYG2fFblOCCwed8+etNbCUrtRIoPZxaLh98eSnUQDL/Oy6yfXcyVFuVPvF4uWMAGuaMsDGEia07p6uTp62TD4t/9CFNP6vEXyUJ6F8NPd64DiImkrVA5VIlfM42HZEGEpwzC96lNzGmIv4On/0I+aw8CN+iibjbxNTnJg8LSXg3kNCyncSsrEVwQb1CV6iqKqxQAu8IW1r4plBYP37C6R+/rm0X5x0sfFJQB7lI5co2703X4Zn+q1HK54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(2906002)(4326008)(316002)(66946007)(8936002)(26005)(110136005)(186003)(6486002)(31696002)(2616005)(508600001)(83380400001)(66556008)(8676002)(38100700002)(53546011)(6666004)(66476007)(31686004)(36756003)(5660300002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJSVEJOREQzdlhkYXhwNzZ3TlRnNUg1eXJ1TEFyUTI5NDdmSk9uOUNFU1pz?=
 =?utf-8?B?WVJDaEV3V1pIMEtyZm02Y0l5NmhFTlV6aE5KZ01lVk9RMDFCTjMrcHRxWkZs?=
 =?utf-8?B?WUNRd3dRWGsvTGRRK0RNRGdsS0FhOG1Qa1FYWGE2Y2I0aTNGaitUbURkYWNK?=
 =?utf-8?B?TmRKb0l1VXdZRXNTNEJLdHQ4NkdOSHNHUllLdkVoUStSYkFRSEI0TDZLUUww?=
 =?utf-8?B?OFRwb1R6ZEZCcExHTml2dVhRczVGbnNGd3FzNXRadlNJdFJjNCtvSm1TaGpX?=
 =?utf-8?B?VHFoTmNlL1FnbU9zZ2E3Mmk4SzJoZjBWZkdQdERyYUh4c05DeGpxNVExbURD?=
 =?utf-8?B?Y0lDYURBM0xMV1g3R3NQQ3JOWWpoeTl3YXd2Q0x6bkdDb2duWVYzWkRvNEhv?=
 =?utf-8?B?SzhITUN6ODUwaXFYZzAzNEZPeml1MnFyaUk2UTNLcklFUVJ2dmpZQkY1WXp5?=
 =?utf-8?B?a2tBOXNubnZtVlZROFh4SGF3eDY1VSs5ZkFXTjNsbGtMeEx4UUNGVVJiRFVt?=
 =?utf-8?B?UGtDb3JZQkJHdEM2Qk91MEp3RHhJbkwzU3Rob1dYbnlSYmN6czQ3RUVKaDNi?=
 =?utf-8?B?ZjA1bU5NOVp2TXZRdVVRaThSSVBiQ1JMMEVreWVtR3lkbm9xTUQ4R2NxclBM?=
 =?utf-8?B?d1gveDYwSEVaZE1IVkR4c3FTdWFkdUt1MHVOSmNXenJCbzF6SjlmVFZMRkIr?=
 =?utf-8?B?TE9OUWhCeXFJK2htZlBGTjRaN1RJZFdWWXVRUjJWWVNEcFN5MzNuZXdHNjd3?=
 =?utf-8?B?ay9nZ1BrM0IxMWRTa0hkU0h6bTgxdVpPVXdzTDJxZnFORTEvOGRKTGtUUmRw?=
 =?utf-8?B?YkZrZVBFc3AwVjRWVmNZdEZNWmpRZ2k2UGhOVjJqSndzTUdVR3NZRVhlV0hZ?=
 =?utf-8?B?WEpsOXlBSHgrMytQRnltZlhBZ0pyeDkwZ3cwYXhienVkR3prYWtPanl6Vm0y?=
 =?utf-8?B?Q1RaZC80Q3lxeEJrWnQ3Lzh3L08va1NQWktzU0tSRjEyVWNYN2xySWpLOTZa?=
 =?utf-8?B?MS9LTjlmR254akRuaExycGVqcVA2OHJDNG9ROWFRMmpvc09MVmV2dVQ0N3Fa?=
 =?utf-8?B?RVMxQXRCd29kcUordW1sT1pNOHhNSkNqaGsySmo4aUw2RXBLdTRvaDhVNml0?=
 =?utf-8?B?SUFzOE1KVlBjZFFQeUpodEdPb0ZXZlFWTzVvUFpUTVo3Y1Z4VjRVemxzTzEw?=
 =?utf-8?B?Q2tOUzZHNFlCYUNySFBtSHZGZ05NZUE2Q2VZTjlydmJaZnBPS0tJRHZuVGo4?=
 =?utf-8?B?elZ3ZXhGVnpFaXFPWW0yKzVtaXNyUWFWUExKTzlMQWEzT0dONWlNQmNXbENM?=
 =?utf-8?B?RTduOWRteS9zN25MelRITTJHemxMdS9qU0N3OUhHelM2d0ZtWFZkcU1rekRJ?=
 =?utf-8?B?eXV3ZDZYOHU2eFVOc0V5bzRSaytLQWRjNmxRS29iZjBpNmhzb3VsQk5yWkJE?=
 =?utf-8?B?VWlLTDBKUUljUU1Ubmd6eFAyNEJmUnd5QTdicHlwTUFRcXlsYUlxUXJtckV6?=
 =?utf-8?B?TmpiTHRZQ1BQVzFEaVFOclJvOWdvVWUvQzFKbDlLOUFnd2RkMXl3SGxIV2hn?=
 =?utf-8?B?bTFBVWh0L1NxSHJ2QmczUlBSYW1xK0l2d1pZdytUSWJUaENmL2poNnFBbFpO?=
 =?utf-8?B?VzlZdm50NG9rR1MvdlpqNUk5KzlVeHYyWjh5b3V3NXlyYlZFYXBlNDJzeldK?=
 =?utf-8?B?WjNJZjFTUzFnYjJkZTF2b0FzZGdVSVVESXdMVmtiMklOVk95R2cxS3FsOVF2?=
 =?utf-8?B?TXdUS0RoTWNYcFJaR1dpMmlwdjdnN3hIenR2Z0xiVkt5b05PUTJhZ0FYSG1P?=
 =?utf-8?B?Tm1MRmFVNlRlQ2R6KytqeDgzMzNJS092VmFWRzdEVVdvRmFmV3gvUS9nNWwz?=
 =?utf-8?B?S29uY1lMVHpEOVBFaG9na2c3b2JudHNndWU2dEhjZ25tbU1NeWxONkNVaWFJ?=
 =?utf-8?B?bWl2S2J5RWpWTFhoOG9GQnltQWwvbm9QRmI2TXpqdko1aFhQUDhlb0ZKYzB5?=
 =?utf-8?B?b2wzVGdkVnc1dElzZkdVbWZaRDRLSXkwdDhHeEFvVzlOcUFqaDk0NjVxaTFn?=
 =?utf-8?B?cTdQZmZ2ZGtpbDhiUG04Y3k5ZFA3Smp5anJsRzMyNTVNTWM3Qms3UWNHck5W?=
 =?utf-8?Q?IA6U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bc182e-dd46-407f-ca60-08d9dbb592e5
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 01:38:35.4263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOlvIwL7NsH6fWFTgdwmT0oWHXADDDC2p3pKN2Iu5R4JwMcZrCgsqjzOAnFavHB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3892
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

Yes, return is not necessary here.
I'll apply this patch on dkms-staging to fix the compile
error.

On 1/20/2022 1:10 AM, Deucher, Alexander wrote:
> [AMD Official Use Only]
>=20
>=20
> You can just drop the whole line.
>=20
> Alex
>=20
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of maju=
n <majun@amd.com>
> *Sent:* Wednesday, January 19, 2022 7:57 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* [PATCH] amd/amdkfd:Fix the return value in kfd_process_queue_m=
anager
> =C2=A0
> Change the return value of set_queue_properties_from_criu()
>=20
> Signed-off-by: majun <majun@amd.com>
> Change-Id: I11362eb76eee84e64c5207c24a2b78141f62e63a
> ---
> =C2=A0drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index ec62897914da..f70e972d1d33 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -826,7 +826,7 @@ static void set_queue_properties_from_criu(struct que=
ue_properties *qp,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp->type =3D q_data->typ=
e;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp->format =3D q_data->f=
ormat;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0}
> =C2=A0
> =C2=A0
> --=20
> 2.25.1
>=20
