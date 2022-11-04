Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD38C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 09:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4101A10E077;
	Fri,  4 Nov 2022 09:49:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4CD10E077
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 09:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiTkIkUpZSD3yDsoGiJjJPTVdsq25MaGCb9IqsCATIM1GKWAv2qjhxxrFmK5x0fXylOIRPAi7ISurXsa3+7Ec7Je7iaxIahghQPTVW/LzJu7zT592acvzrfUHnnCYGJiGKISF1z8iKZ9fESxFf8OZJixNseUaW2BPCzE+d7iTHFviO9ky5J0qIRkXvqrupFoTPPld+hAbdMAXWy7k/F56IC766yS6nr2vWHGABMMTCeFYWh1GcgIkhEbAHF+VUucPf4eOUV0qA6GiLRcwVM4SLb6x1SyIN7AhJjWfmWQt8aS905vqkdX9tUyvZMte3szXi3g/mo/SyGtbeXDn4LDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6rxnHvnuIv/jTN+Xt2+fiHgdl3U0NUMUTFB9+GNNs0=;
 b=mMqL0FgpYifITvsPlYNzMeQbzps8jsy5H3edNZSJptmMwpDg/sDsn4ZYP0FmHZ5cJtyaD++t8Iew08XfHSi1ghU69PCTBZXMjIW6pchGOWc3OFz0Wn678q4K66EivDIVs/S3fkpJyjAly5EhQYEKSpTunR7ls3ckRD1/nnm9nE35zXzqwBJRjLW7wAfcC3sSX57nlza9serrRLDa/l37D40nAcBAtEGu9OmzR9IpB8sNVa3Yqn+gOhfGlSXtSL4qAzphKmUdchO5Sy2n+mHH9vfRFh1XfUgWlBjAdNtbgT1c74X0Ribwk21cZcLBDROnlX863jvYGbKbzoTGW7rgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6rxnHvnuIv/jTN+Xt2+fiHgdl3U0NUMUTFB9+GNNs0=;
 b=oyQt9oQ9N0kh1LStaYfEyxcYB+kk3vgudisGuI/i+ulnHz7iNNrBOPIzW/+dkbMVYDd8EflzOUrcDdxNlVS0Eg1+oTxOVGlA4JCfhjRq8MIyO88vG009BtS7/t4o9w18JsYZTMxqIFdgr6A7XTGt6kO6ElNpW5sEX0CBGY55zOc=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 09:49:39 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::b164:7713:3314:8e22]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::b164:7713:3314:8e22%7]) with mapi id 15.20.5769.019; Fri, 4 Nov 2022
 09:49:38 +0000
From: "Jain, Harsh" <Harsh.Jain@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: wait till Gfxoff allow signal completes
 during suspend
Thread-Topic: [PATCH] drm/amdgpu: wait till Gfxoff allow signal completes
 during suspend
Thread-Index: AQHY8ARHnA3wXSLKWECPdEoR1gw6BK4uZxiAgAAVihA=
Date: Fri, 4 Nov 2022 09:49:38 +0000
Message-ID: <MW5PR12MB568431B2F0A8B4297D0D5B589F3B9@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20221104041634.963830-1-harsh.jain@amd.com>
 <DM6PR12MB261989F4BF49FCD62AE8F1B5E43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261989F4BF49FCD62AE8F1B5E43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-04T08:00:52Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d69527d3-bdd2-4199-84f8-c232fba3a8b6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|BL3PR12MB6449:EE_
x-ms-office365-filtering-correlation-id: 1e96c6bd-689e-44f6-91a4-08dabe49e3bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ytIw+yiCefV8VtXps0FFTUo3ZqUBloJ4/i4aNk82QmQQueNYXjjmAoxNdOCwM3RWOE/9huxGhWwnLVqXThjOlpd6XeZZ411013c3e4di7na3EXKFF6SMGq1Z5VIB4pm67zDvHwA2gdbW00YAtf2djTA8m7xdKBNgRTb/Zrx5NBskLg1Fl7CrYnVzP8QqWjdmIKLoq4TJ+MBs4M9JlgBxqGwSFqLDIsnYfB1z0uLV+kWKgKDN+zPICqzJepgZdUW5ZmX5y/hLrarwYvVyQZA8ylXWIi++QR7TJw8njUAbyeW3m0l7y1Pb/mIG5zRcsCFl22kH+LqFVKyh7Sv82p/igtw/Kvuk2YmQXL/uUBH+lw88LMAnmtd33EMyNqDpQhO0bLKNeqVjCMpflyZXRkw8QzQZf+VCRG9u0l24i0nS3uP1Sc9ERPnZB9GpJHe37LB0D0YfiDXbCB7+vThQ8kL0LToXjxjklnNAntw03JxhGKOYaNP9dVESvf8xU4rDk8JRMS9nEpOtAO7m2ACTzOg+7mVxL2wRIi/Iies+645l5+8RrOULQRZh/1Iu+XGNDoBLnRdU6LQQYJthWY0x3g2hGnMzqqz+RPdwrigdr0SvpVAoKAlAOnrdJBJ3VznFgY9gzGy3OEprBdkp0u6OWjwGetfOc8mp5AbLT96KSYhmxYqJfGJhr/H/bxVFjSJV4u/3mnJqpmxionVzyQD9M48ZhKzJRg3b5yEl1xqz1Lg52FibcArLzM6SfKqblorTb1f/5MQXM8E34BNDNEA8doftg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(52536014)(66446008)(66476007)(66556008)(41300700001)(8676002)(4326008)(64756008)(8936002)(5660300002)(86362001)(2906002)(55016003)(33656002)(15650500001)(66946007)(186003)(122000001)(38100700002)(83380400001)(110136005)(316002)(6636002)(71200400001)(76116006)(38070700005)(53546011)(9686003)(26005)(478600001)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?otT1qkGghr8EMTDWQsli6smxmPJENYYfiy7xmSH8e16V7DpDF/GEEWQISYeU?=
 =?us-ascii?Q?iGSUB3Nm5euS6ScR9P/A0WPcomhO6H7dfbg6EliZyiEia1s1z8NTjMC0muXx?=
 =?us-ascii?Q?lLOT9f6jVkR/mQE/eE68mN7tvOvJLgsRgfpcm6ltCZ0kSK4fshIdzjqVsMBB?=
 =?us-ascii?Q?UI5e8N2BEy0ZyrwOZT8x8M08torZiIBdg8bskboQcdNx+63/uV7vcdzCb1/k?=
 =?us-ascii?Q?YYIb/JyiaZDrIGZXT0m8NlbgyOlAnT4mQEuhptL7kHLzDdW9yMxZJQ50dULj?=
 =?us-ascii?Q?l5vxlLeU8hSDIuDnh9yLrtKFFHkcVT8ado5vRfosrxNZVpCg/SC2CFk9nfzK?=
 =?us-ascii?Q?9t0peFqUljLBfEEV3P/0uM/tchaJvJdsmUDTAz14TvE+9PnuY71qn+VvWqMK?=
 =?us-ascii?Q?hyoD+5fedNqYSHZFMbK+hSnp+axo8HHxnJ+n1bVgFAaYROdwg8hscVtKYrap?=
 =?us-ascii?Q?TBuOzEZ4QUL9XtAlWelvNeTpOM46fHOsHsyRcrLwPMO2wLisWMGnxhO5GTxn?=
 =?us-ascii?Q?Bt2KQBvkVw0Ed2vkovbkLx7ULnHWCgzUW9qoVYtmJlEDYcnT6zBVcR/0VXrH?=
 =?us-ascii?Q?DpUnRHyC4QvZ2VIvpol+YTMQn2MpSMmu7CxxkpihV24Tag0TonXddn5ptXe+?=
 =?us-ascii?Q?r0w9dN6up/U6nlw2pUtNmGCtCIIGPbPtEsVBzWDz3tL9is/ASr37jP4GtTdX?=
 =?us-ascii?Q?G8fbgoa4R8SSJpmrTcrjmixelhzICDmCEUPt+BrD4RkWo4l7p7k34x2680m3?=
 =?us-ascii?Q?TBFGgg996NsHmoix1veyzkolY5cpAPPtTTTI6bQpvvS/Zrnz9F0++vWU3OzF?=
 =?us-ascii?Q?FdJUqjOAZIvdLM5J1ym1KHocmVboryMJN6y7PB9eYYX7usVP8cvQfl53ZcZK?=
 =?us-ascii?Q?SKQPae9IuN5CV6euKi+JoU0SxwRAcN7SsEMm7Pz/JfKNpYO7RfJ/MoO7NiwE?=
 =?us-ascii?Q?5kBiPwhCOlWAEQ7NQHNmCZXlK4mDtiNh5mUQJxF0V+54IuFW5Q1Y9nq16SSB?=
 =?us-ascii?Q?MWVwL4p2DMDnol8asPBtp00Ca4oB8DaRgVRB1XJ2+YSWN/5hTXGc/bPRNXAc?=
 =?us-ascii?Q?YdvO8lupBtsI/jxFDUdWqutlAbzuGXldDQTDmF6Zw1dDB/rJQTZ5bmSPxSnh?=
 =?us-ascii?Q?fMq5mhz0visu8vsx3UEeqdlYT15vBFOYyW5tXYdC0lvbeAsKoLkU4blmtd+R?=
 =?us-ascii?Q?t0PU9m0osMITWWukrCqI7oTsKlgwAviZFTkFzls1agrrChdvcE9KXwgJ2qzH?=
 =?us-ascii?Q?56flT0MeSrroAderBzitFG8xLzzlw8+HK1szPm2y00mP2iqTrlW9xX4sxmOM?=
 =?us-ascii?Q?06GCTutkdF/ZfE/EDa2p+2Rc8z/nTlrY5CQR8bT/Jfi/JF+a6jLhlFolJZeJ?=
 =?us-ascii?Q?hPe8ZZF+vAOZg8DndR3Tf/viIpJP9NuqEsvR2UakDX0caH2xUwkvWpud32dv?=
 =?us-ascii?Q?aUCd9CbDDYoT4dj0HkcN92hmbT5mcifdv8d5SoN0vOl4OXMzsUFaSh+k4y4d?=
 =?us-ascii?Q?oeEPI1KHjlL4tbFJEvnmrEfdcGrs8yvofVrHKLrR3qi+ODR+a383Z7huhNUd?=
 =?us-ascii?Q?zEwWxq7kznbel7FiJf7hCUztER22NBzJwcOP1EXl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e96c6bd-689e-44f6-91a4-08dabe49e3bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 09:49:38.8463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8u5xVv4sN/ETRXgff67DeQMiUeiuatROVQ6ytyCZB+0DsKym07HBrzR2ij7EQ9HbKJOlv0SWWyotKDya2d3v5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please find my reply inline below

>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
>> Harsh Jain
>> Sent: Friday, November 4, 2022 12:17 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: Jain, Harsh <Harsh.Jain@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: [PATCH] drm/amdgpu: wait till Gfxoff allow signal completes=20
>> during suspend
>>=20
>> change guarantees that gfxoff is allowed before moving further in=20
>> s2idle sequence to add more reliablity about gfxoff in amdgpu IP's=20
>> suspend flow
>>=20
>> Signed-off-by: Harsh Jain <harsh.jain@amd.com>
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 222d3d7ea076..5b2afe348c23 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -581,11 +581,11 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device=20
>> *adev, bool enable)
>>=20
>> 		if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
>>  		    !adev->gfx.gfx_off_state) {
>> -			/* If going to s2idle, no need to wait */
>> -			if (adev->in_s0ix)
>> -				delay =3D GFX_OFF_NO_DELAY;
>>  			schedule_delayed_work(&adev-
>> >gfx.gfx_off_delay_work,
>>  					      delay);
>> +			/* If going to s2idle, no need to wait */
>> +			if (adev->in_s0ix)
>> +				flush_delayed_work(&adev-
>> >gfx.gfx_off_delay_work);
>[Quan, Evan] This seems a little weird. Can you just call amdgpu_device_de=
lay_enable_gfx_off directly for s0ix case?
>
>Evan
[Harsh Jain] amdgpu_device_delay_enable_gfx_off is a static function in amd=
gpu_device file.
It's better to keep it static otherwise it would create a new api for gfxof=
f control for which current api amdgpu_gfx_off_ctrl  is available.

Thanks
>>  		}
>>  	} else {
>>  		if (adev->gfx.gfx_off_req_count =3D=3D 0) {
>> --
>> 2.25.1
