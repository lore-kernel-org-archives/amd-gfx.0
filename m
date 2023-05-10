Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306E8C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C03E10E526;
	Wed, 10 May 2023 20:54:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F7A10E526
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2EFTKDzkekakgWdoFHMCAky5MPIA7Z6Qrut8SObMqhJhjoC/WJ5KE2TOdHv6GBO0Sbu3/91zA81ZOIPazz+pkcVh0cO47x1rIcCvvGti+jO9SAmk3BEL6W8Wc53Uv0t9c3sUmPSMSHKIjtRLOSKSsdrKzqUHtts/rYDh/5qz84qKmwyDwE5hpFLifzK5dVwROgjtbSLGzvV9JkupIWGPwbhTB+oARdXJOVYOzwTPdxgMFxIMt3znXKBik5UAr+JI6Lm5t5Q4HNVqPTbOwVI30vfyVJAvpuPttzBB7xwrwY1weK3VpH7lYziXJvEtYxXsb+95xbeDxwYJ/j7yBBiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z66SUd798O/YY4GjDfz2yeGIufrPQY15Z5KLXmU62Bs=;
 b=V+8N8LjPv++E0L+5JWhR7yeQOkPBxH9AfKObYLMeq6HJdCyv/YcpqPAt3hxSsUYTdZ/12n1Do7/wdr0BXCX9va/1bo4O1x3nwuF+b1oPkTJZcAMFeM2qck82QZedMuLFZdIntuJkk1bonPSjlQrMcmjuPBlqFFkJV/4TAdlP2FXmMgrhV0MwHTMvgBI6RvvgU8wNSpKoM38qXXfYgMzm8imKY83/8MIOo8IVJsgglyWEHw22AnUb/FC+XVd2td3s0BFORpYPfvOAsZR7uXH7kYBpl6aBa3AAbWKOw9+GLAm2kQpGjlXxsCshu6sDSSaN/Cq/EZFXa4sUci3uFllzgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z66SUd798O/YY4GjDfz2yeGIufrPQY15Z5KLXmU62Bs=;
 b=z1PrlNVjXNz9aco+3g6pJTk5BIdf8u/GTLRlni5etblv21LgwQmndaFFV84LLNPm82cZ+rly+NRzzKAMCKOvcPBntzfnbNvholeE0R9ULvahc9OMKzKR6/ogich77YNqLlGL657byn6EfNLnUV76qYZxoY53Spngak31w7M+/Zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 20:54:10 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11%3]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 20:54:10 +0000
Message-ID: <14582e0e-58cb-02df-50ae-1af22d194b29@amd.com>
Date: Wed, 10 May 2023 16:54:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Content-Language: en-US, en-CA
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Chalmers, Wesley" <Wesley.Chalmers@amd.com>
References: <20230414155330.5215-11-Qingqing.Zhuo@amd.com>
 <9deeb132-a317-7419-e9da-cbc0a379c0eb@daenzer.net>
 <CH0PR12MB5284513F3548D749845BD7B48B769@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CH0PR12MB5284BDF5F23009597E1503E38B769@CH0PR12MB5284.namprd12.prod.outlook.com>
 <714c875f-21f1-7e29-fb39-4a1f97eb712f@daenzer.net>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <714c875f-21f1-7e29-fb39-4a1f97eb712f@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: YQZPR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::27) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f0fdc7-faae-48ff-b215-08db5198b3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0FmuRKCfos9BbI/EPeUCkOpwWai+YlTCur+9Pi5NqOkqimE/Fwa4k7dz5wFUNEuI9r5KQySqren4f2Ln/7pmlpiqw1qZ87FdR9yaZn5vx3vNYNGng3jDRHKlEVarOs/nA28tp2uQcqeq76v3KJ9KYpGYohgbgVZgfS2PJJidQKXl2KY5sdgD/w9EkmB2VEwY9MMO63UdUA3dOAUK+sJov5GRuC3Hp2XnKEGsLtUdgbIYyRc+tJvzIwcVhSiwZptmO0AiTxT6y6szKMRhJQfCKYudpXTYxHmLeiuS/8XnsXPun3LiRyC+e2PjodB+mYjyQrX2wUUNXC7PGxfxcLNkllqIQQ5fUx53bttYcLufKrKkCDsi+rt74Dxji58gQCazY7hV1lT9Wa17ULciaspap0PYeyL2+tW5yyApNBzY5kF1nGhLpXZNI6HOysgjTox3LByI1ZK1yYNP0GKpR+OQsTmBjYZZ1Yth1uKCIcBj5/MancIPNqGGIUZ974lwbN+S8XnBbpsbFmQSlZbkjp3SUjtGZXKSHrw+XFRJNhqzr5lp0k/RX1orb2YQOugLvRmYDVoG9DS+0RGCgjOWAldfB6hCQ2a9tdgawqxOx9n9VpvcCroagkVrxBOBCAnqWe9DcAnfkbRak51ghJNatLwHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(83380400001)(6486002)(966005)(110136005)(54906003)(6512007)(26005)(478600001)(53546011)(6506007)(186003)(41300700001)(8676002)(6636002)(66946007)(66476007)(4326008)(6666004)(31686004)(8936002)(66556008)(316002)(2616005)(5660300002)(2906002)(66574015)(44832011)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXBZbWFxU3FENGZSSzd4dktTSGlhVzQ4aFJZUGhRTWhpR3ZGNFc5NHJiUkdK?=
 =?utf-8?B?akg3TnBXNC9ZVjN1QS8rSXlIWmxtUDY3VjhQMkdFLytRcEZ5L2grUU9NdDhn?=
 =?utf-8?B?azQ3QytLd0JUL3hPeUlORVhKT0RkUDBIcUdkb3JoQXRjbXBxU3REWFBXaU9Z?=
 =?utf-8?B?ZnRBQnpaMEpmY0hsUkRPZXZlOHMrb1JaeStYdEJVOHh2cEkrYzNUaVFDY1Vz?=
 =?utf-8?B?dFlXVTdYYXJNc2lQc0U4U0I3VldPVFd6UGFKaWU3WlgrM21pSCtzOFhwOHZj?=
 =?utf-8?B?dHFNbEFHY0xpdWZvd1JLSUlKWjJ2Sm1ueTlIRHlIR3BrZW1mZGxjTGxIZGh6?=
 =?utf-8?B?ZHVrVjcvRGRLeFgyN0F6TThpdFVsdExJSTJPRUdBNldpRTB5bTlDb2pRMVUr?=
 =?utf-8?B?OTh3UHlSRUl2NFFCb3E3dzdyQnh3cEFqaUxwc1VCNStRekIvbW0yU0lPOWpD?=
 =?utf-8?B?QXNPcXp5Z1J0Wi93VlM0N0drSysraDhocnlEM2lKTStxazJZamtZOFFhR2RI?=
 =?utf-8?B?UTRreTVHZ244UTlHeUZuZ3hGbVJ2UHJ2MjdIV2hvWTh5SkdrVHR4eW5qV0RC?=
 =?utf-8?B?L3Z4OVVwUEFiZjNoWVM3c1lydTNReTdxbjk4Rzhtc3V4VlRGeEVUbVZyNkRO?=
 =?utf-8?B?bVR4UGhmNnFXTHdveldOc3pVQnBiZUV0VlNFNzBwZ043YWpjUjZCUldXVWhT?=
 =?utf-8?B?NXUwS3d6eVRyZG1KcG9jN0JMbW5zNzd2NXdZOUd3WXh6KzlxM2VVSVJ5ZjBO?=
 =?utf-8?B?elJVMEhWZEx1dlZNUjdWbk5vcUdRdHNYaE9ybS9HQ3pYczhramNQOTZWTUpr?=
 =?utf-8?B?eFJscktLUmQ3aXdzNm9uejRBRzJ3RTBvd1Q2R09Gem9uaW14dGs2aDZyaE1J?=
 =?utf-8?B?cHFOR0lhT1ZBRUtvdkFzcklTTlhWSGxOUEJuU3RyMjQxSzNXRTR4VFhvSE41?=
 =?utf-8?B?MGxNOGFvWVRyWDEvZXJZUGpJZHdGOG5ES3JnekRBdkVVTjNDZ3dXSnU4cWVs?=
 =?utf-8?B?MmJiUDVUSWRpc3hXWG5JeklKWTB5SkNjYnVPQzFPNDdNYStyZGczbDFYWm1U?=
 =?utf-8?B?a0tvRk9LNmkvWnVZd281Vm5TaVNSa1ZsVmRKNjh2Z2FwWWVTYjhLSTMvNitt?=
 =?utf-8?B?b0VpWldWS0loMzIvTGZiQ1E2QVBoSzVOQjRadTNrQVJySGJ3ZFh2alh0bFNF?=
 =?utf-8?B?RG50Q0t6VStQaVNCNXZIZkFBU0llWGh3clFFRzRIdDZrNlRRcWlzM3lLelNr?=
 =?utf-8?B?WitNUFFja2ozUjZ3KzJTS2w5bldQcjhHRS9MaHVnN1VqbzNUVUNEcHQ0ZXJL?=
 =?utf-8?B?eExRMDJQTndCVFRqd3VJTHhzL09OdVY0bitZYWoranNLUVF2bEdMTlBEcUZw?=
 =?utf-8?B?a0JsQ1JMMWRyNGx2Q2I3WnVCZVMxSGFvY2lFQ2laK3pIbGw2RHRnK1UvQ1dr?=
 =?utf-8?B?b3dlMVU2bVVzc2xWelVxeERRRDVTdzZzUk1MUHlSdlloM0hHeWpXNXRsMDhh?=
 =?utf-8?B?djRGRWNzTjlhRHZHR0lKcEswcHdlQUxwVlI5aFdOU3lLeWdlQnRxTUwxdXhM?=
 =?utf-8?B?WHNXc0ZTWmhMR0t6eGljWUlCTWxFQ2hsN2NXM2gxRE05aE9MUFQyaTZsK24r?=
 =?utf-8?B?UXBJaG8vYnpuWUJId0lScFh3YUROcEl2Y3FyTElCT01sN0l4eUlYamhVRWpV?=
 =?utf-8?B?S1luYkhNcGlTTVc3UWI4TjlTNUd5T05Ec0hEMW93cFhRdjBvWlBFMU1wYlIr?=
 =?utf-8?B?d2pYMk51ZWs4SGJnUTFqdjAweFcxbFp5NlN2KzdwRUt2a1hCTnhyZGlSU2dY?=
 =?utf-8?B?emJ5amZsVGsrWTJJcTd0OU9JWWlUa2liZnh5WXhCWkpSUDBRRm1rckUxa1Vq?=
 =?utf-8?B?bEc1bTEySUhFcUsyTFRsT1lndmljeDVXV3pvL1VNc2xWSTV3OWMzZHJZOGUy?=
 =?utf-8?B?TDJNWEl2RGkyZ0k5K25FVzNzcmY2YUNNNmh0Tlc3S0hQcFUvR3dUL1JObEhv?=
 =?utf-8?B?L0M2a1hoelhSeDlvNWZjUGQzNTNTR3dJMW5RMk9ydkhDZFJBbFFYckFCdXBW?=
 =?utf-8?B?WUcrUXAxVU5rckZueUtZU0xlanNicEMxQldVUnUwR3ZwckxWeDlINzYrbXYx?=
 =?utf-8?Q?4UEBeqS+E2Atq59cWgmGpNlO8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f0fdc7-faae-48ff-b215-08db5198b3e1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:54:10.0191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2U1SbEsvrYxQ1GFY74zNOEwqKCluYqbjYNGoesZUhZ6cvunx+bC0p6hsoXH5hXnrCQtJpGnmYYxiWc9XFyjzIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/10/23 09:20, Michel D=C3=A4nzer wrote:
> On 5/9/23 23:07, Pillai, Aurabindo wrote:
>>
>> Sorry - the firmware in the previous message is for DCN32. For Navi2x, p=
lease use the firmware attached here.
>=20
> Same problem (contents of /sys/kernel/debug/dri/0/amdgpu_firmware_info be=
low).
>=20
> Even if it did work with newer FW, the kernel must keep working with olde=
r FW, so in that case the new behaviour would need to be guarded by the FW =
version.
>=20

Agreed. Were you able to repro the hang on any other modes/monitors?=20

>=20
> VCE feature version: 0, firmware version: 0x00000000
> UVD feature version: 0, firmware version: 0x00000000
> MC feature version: 0, firmware version: 0x00000000
> ME feature version: 44, firmware version: 0x00000040
> PFP feature version: 44, firmware version: 0x00000061
> CE feature version: 44, firmware version: 0x00000025
> RLC feature version: 1, firmware version: 0x00000060
> RLC SRLC feature version: 0, firmware version: 0x00000000
> RLC SRLG feature version: 0, firmware version: 0x00000000
> RLC SRLS feature version: 0, firmware version: 0x00000000
> RLCP feature version: 0, firmware version: 0x00000000
> RLCV feature version: 0, firmware version: 0x00000000
> MEC feature version: 44, firmware version: 0x00000071
> MEC2 feature version: 44, firmware version: 0x00000071
> IMU feature version: 0, firmware version: 0x00000000
> SOS feature version: 0, firmware version: 0x00210c64
> ASD feature version: 553648297, firmware version: 0x210000a9
> TA XGMI feature version: 0x00000000, firmware version: 0x2000000f
> TA RAS feature version: 0x00000000, firmware version: 0x1b00013e
> TA HDCP feature version: 0x00000000, firmware version: 0x17000038
> TA DTM feature version: 0x00000000, firmware version: 0x12000015
> TA RAP feature version: 0x00000000, firmware version: 0x07000213
> TA SECUREDISPLAY feature version: 0x00000000, firmware version: 0x0000000=
0
> SMC feature version: 0, program: 0, firmware version: 0x003a5800 (58.88.0=
)
> SDMA0 feature version: 52, firmware version: 0x00000053
> SDMA1 feature version: 52, firmware version: 0x00000053
> SDMA2 feature version: 52, firmware version: 0x00000053
> SDMA3 feature version: 52, firmware version: 0x00000053
> VCN feature version: 0, firmware version: 0x0211b000
> DMCU feature version: 0, firmware version: 0x00000000
> DMCUB feature version: 0, firmware version: 0x0202001c
> TOC feature version: 0, firmware version: 0x00000000
> MES_KIQ feature version: 0, firmware version: 0x00000000
> MES feature version: 0, firmware version: 0x00000000
> VBIOS version: 113-D4300100-051
>=20
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
>> *From:* Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
>> *Sent:* Tuesday, May 9, 2023 4:44 PM
>> *To:* Michel D=C3=A4nzer <michel@daenzer.net>; Zhuo, Qingqing (Lillian) =
<Qingqing.Zhuo@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freed=
esktop.org>; Chalmers, Wesley <Wesley.Chalmers@amd.com>
>> *Cc:* Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) =
<Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, R=
odrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solo=
mon <Solomon.Chiu@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpr=
eet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.=
com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
>> *Subject:* Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe com=
mit
>> =C2=A0
>> Hi Michel,
>>
>> Could you please try with the attached firmware package if you see the h=
ang without any reverts?=C2=A0 If you do see hangs, please send dmesg with =
"drm.debug=3D0x156 log_buf_len=3D30M" in the kernel cmdline.
>>
>> The attached fw is not released to the public yet, but we will be updati=
ng them in linux-firmware tree next week. Please do backup your existing fi=
rmware, and put the attached files into /usr/lib/firmware/updates/amgpu and=
 regenerate your ramdisk. On ubuntu the following should do:
>>
>> sudo update-initramfs -u -k `uname -r`
>>
>> --
>>
>> Regards,
>> Jay
>> ------------------------------------------------------------------------=
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
------------------
>> *From:* Michel D=C3=A4nzer <michel@daenzer.net>
>> *Sent:* Tuesday, May 9, 2023 6:59 AM
>> *To:* Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; amd-gfx@lists.fr=
eedesktop.org <amd-gfx@lists.freedesktop.org>; Chalmers, Wesley <Wesley.Cha=
lmers@amd.com>
>> *Cc:* Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) =
<Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, R=
odrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solo=
mon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; L=
in, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.co=
m>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.K=
otarac@amd.com>
>> *Subject:* Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe com=
mit
>> =C2=A0
>> On 4/14/23 17:52, Qingqing Zhuo wrote:
>>> From: Wesley Chalmers <Wesley.Chalmers@amd.com>
>>>
>>> [WHY]
>>> Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
>>> pipe commit can cause underflow.
>>>
>>> [HOW]
>>> Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
>>> optimized_required.
>>>
>>> This change expects that Freesync requests are blocked when
>>> optimized_required is true.
>>>
>>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>> Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
>> I bisected a regression to this change, see below for the symptoms. Reve=
rting this patch (and the following patch "drm/amd/display: Block optimize =
on consecutive FAMS enables", which depends on it) on top of the DRM change=
s merged for 6.4-rc1 avoids the regression.
>>
>> Maybe "Freesync requests are blocked when optimized_required is true" is=
n't ensured as needed?
>>
>>
>> The symptoms are that the monitor (Samsung Odyssey Neo G9, 5120x1440@240=
/VRR, connected to Navi 21 via DisplayPort) blanks and the GPU hangs while =
starting the Steam game Assetto Corsa Competizione (via Proton 7.0).
>>
>> Example dmesg excerpt:
>>
>> =C2=A0amdgpu 0000:0c:00.0: [drm] *ERROR* [CRTC:82:crtc-0] flip_done time=
d out
>> =C2=A0NMI watchdog: Watchdog detected hard LOCKUP on cpu 6
>> =C2=A0[...]
>> =C2=A0RIP: 0010:amdgpu_device_rreg.part.0+0x2f/0xf0 [amdgpu]
>> =C2=A0Code: 41 54 44 8d 24 b5 00 00 00 00 55 89 f5 53 48 89 fb 4c 3b a7 =
60 0b 00 00 73 6a 83 e2 02 74 29 4c 03 a3 68 0b 00 00 45 8b 24 24 <48> 8b 4=
3 08 0f b7 70 3e 66 90 44 89 e0 5b 5d 41 5c 31 d2 31 c9 31
>> =C2=A0RSP: 0000:ffffb39a119dfb88 EFLAGS: 00000086
>> =C2=A0RAX: ffffffffc0eb96a0 RBX: ffff9e7963dc0000 RCX: 0000000000007fff
>> =C2=A0RDX: 0000000000000000 RSI: 0000000000004ff6 RDI: ffff9e7963dc0000
>> =C2=A0RBP: 0000000000004ff6 R08: ffffb39a119dfc40 R09: 0000000000000010
>> =C2=A0R10: ffffb39a119dfc40 R11: ffffb39a119dfc44 R12: 00000000000e05ae
>> =C2=A0R13: 0000000000000000 R14: ffff9e7963dc0010 R15: 0000000000000000
>> =C2=A0FS:=C2=A0 000000001012f6c0(0000) GS:ffff9e805eb80000(0000) knlGS:0=
00000007fd40000
>> =C2=A0CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> =C2=A0CR2: 00000000461ca000 CR3: 00000002a8a20000 CR4: 0000000000350ee0
>> =C2=A0Call Trace:
>> =C2=A0 <TASK>
>> =C2=A0 dm_read_reg_func+0x37/0xc0 [amdgpu]
>> =C2=A0 generic_reg_get2+0x22/0x60 [amdgpu]
>> =C2=A0 optc1_get_crtc_scanoutpos+0x6a/0xc0 [amdgpu]
>> =C2=A0 dc_stream_get_scanoutpos+0x74/0x90 [amdgpu]
>> =C2=A0 dm_crtc_get_scanoutpos+0x82/0xf0 [amdgpu]
>> =C2=A0 amdgpu_display_get_crtc_scanoutpos+0x91/0x190 [amdgpu]
>> =C2=A0 ? dm_read_reg_func+0x37/0xc0 [amdgpu]
>> =C2=A0 amdgpu_get_vblank_counter_kms+0xb4/0x1a0 [amdgpu]
>> =C2=A0 dm_pflip_high_irq+0x213/0x2f0 [amdgpu]
>> =C2=A0 amdgpu_dm_irq_handler+0x8a/0x200 [amdgpu]
>> =C2=A0 amdgpu_irq_dispatch+0xd4/0x220 [amdgpu]
>> =C2=A0 amdgpu_ih_process+0x7f/0x110 [amdgpu]
>> =C2=A0 amdgpu_irq_handler+0x1f/0x70 [amdgpu]
>> =C2=A0 __handle_irq_event_percpu+0x46/0x1b0
>> =C2=A0 handle_irq_event+0x34/0x80
>> =C2=A0 handle_edge_irq+0x9f/0x240
>> =C2=A0 __common_interrupt+0x66/0x110
>> =C2=A0 common_interrupt+0x5c/0xd0
>> =C2=A0 asm_common_interrupt+0x22/0x40
>>
>>
>> --=20
>> Earthling Michel D=C3=A4nzer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://redhat.com <=
https://redhat.com>
>> Libre software enthusiast=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mesa and Xwayla=
nd developer
>>
>=20
