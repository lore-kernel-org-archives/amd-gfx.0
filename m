Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E7C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 12:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E012173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 12:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EeuRd/Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E012173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE186EB1F;
	Wed, 11 Dec 2019 12:18:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6436EB1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 12:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmxUoi+IHp7VFD5a4rAiV1WjVR0T8mD63bNe1W40XRYc2SjksFkcl5JQgxW+MrA6Ibry3ZgxIFja/s9sTfORnwwe1PfBWPCSC2cn8GPKFifsJ1uuGAwhNA1ilUydE34X1XknJ5ILd8upu38uuiKr7A8I6BF2typPUUbyD4mHwIbLnS/3SOC6YJs+VYzn4/FpeKNVkqXZSJ2A0KKBQxQGee2bQeEqyLeyttX0CCKZbaJAM/X74ug+V2WNhuawrTNrrG1QASvzS6kGDLzDmYbo4a6+cUbFgLf43qyQHZsm3IM5yL/Xx+jSeR8Xg/3AuDrzQTgDYHEZB0EG+MnyvDXmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a11NOIjXI5V2IBcRHRZXRIOp1+EhadCtxFXGzKRlT1Q=;
 b=RdDagou0sL8uVBP2AFKZlihhqieZj68GWRx4iN5v+nYVnIDJK5P19kXy/0Bd1ebbLVe1NoldBcvRhu2txFrsA2Fb14jW7+veFtsb2YkGqXjOpVWBfPeM9o2AO4K208ctB029ncQAZNa3U4k6ws3X0xJSKxoeG10bGRdqRdM0dDRSutOP7eBYvpi71lGSkKcYCl0FmXyglhAwcD9j2ms7mVFGM2v8Cgo/xLx/JSwjYRM2biG7rQ1ASPEXS4xciNRpK1W9l5lQOpS/dhbLQzBNMCWg8S/V58xP2FJWCDPiqFlV6Gjm1HSTkNmE4LPbUNLs45E0/Yz7uzzcCpVqLXPQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a11NOIjXI5V2IBcRHRZXRIOp1+EhadCtxFXGzKRlT1Q=;
 b=EeuRd/KbyewP/EgjroXmogkZOJVblG9C7PGprsxAknSK96gra5CZOmRd76juynoGZS28/a8kgAQMfe4l8MCDs9nvU+Nt2RWtsuXzfyglPoWGUh1vgTdknwLZysWmnsD6u2lTo0DFaNhIJM1x3JDeJCN9OB67UMEnzah+xYp+bbY=
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB3069.namprd12.prod.outlook.com (20.178.241.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 11 Dec 2019 12:18:11 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::dc02:3d41:a510:98f6]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::dc02:3d41:a510:98f6%6]) with mapi id 15.20.2538.012; Wed, 11 Dec 2019
 12:18:11 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
Thread-Topic: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
Thread-Index: AQHVpQNJI33CWgVjAUaqRB+BX0VW26efKZkAgAETysCAAhrWgIAEZr3QgACwIQCAAMiIcIAAkXkAgACckSCAAMmfAIAAsiLwgALS/QCAA/l1oIAAWV0AgACwm6CAASXIgIABDDTA
Date: Wed, 11 Dec 2019 12:18:11 +0000
Message-ID: <MN2PR12MB42855499B960506C3BA62198F65A0@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <c09d7928-f864-3a80-40e2-b6116abe044c@amd.com>
 <MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com>
 <157d7671-803c-4f6e-f77c-9738f32905e3@amd.com>
 <MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com>
 <5b505116-17aa-383d-5cdf-246663a1f4f9@amd.com>
 <MN2PR12MB42855B198BB4064A0D311845F6420@MN2PR12MB4285.namprd12.prod.outlook.com>
 <2c4dd3f3-e2ce-9843-312b-1e5c05a51521@amd.com>
 <CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com>
 <0cf9f58a-3ce4-2a9c-cb1a-db3cb13760b9@amd.com>
 <MN2PR12MB42855296AE5C7EDA968AA442F65C0@MN2PR12MB4285.namprd12.prod.outlook.com>
 <a38e95ac-ca7e-20fd-0c2a-4d4310e8599a@amd.com>
 <MN2PR12MB428581A895E0C2B26542CC1DF6580@MN2PR12MB4285.namprd12.prod.outlook.com>
 <b44fcb10-d1ed-c93a-8010-5b62aae74545@amd.com>
 <MN2PR12MB4285B04000E228E467F8004BF65B0@MN2PR12MB4285.namprd12.prod.outlook.com>
 <6942e47f-fcb6-0fa4-fdf9-4c0ad936ef90@amd.com>
In-Reply-To: <6942e47f-fcb6-0fa4-fdf9-4c0ad936ef90@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-11T12:18:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=da0e4bd3-7bf3-48bb-9a0f-000019fca370;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-11T12:18:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9318b593-0f42-42f0-aab3-000049f3b397
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=Le.Ma@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0e22426-4346-4888-24f4-08d77e3430c0
x-ms-traffictypediagnostic: MN2PR12MB3069:|MN2PR12MB3069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3069DA325BAC557D5C9D9857F65A0@MN2PR12MB3069.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(52314003)(316002)(9686003)(55016002)(478600001)(110136005)(186003)(66946007)(76116006)(33656002)(64756008)(66446008)(2906002)(66556008)(66476007)(26005)(5660300002)(71200400001)(81156014)(81166006)(7696005)(8936002)(8676002)(4326008)(6636002)(86362001)(52536014)(6506007)(53546011)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3069;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B4DVb+ZhQT7kPmhIrsQk2i4j370IjMrkU2wzgM9bQg372sLK5nxiL9QHm0T+jytHUhrYfIdMlXX7cK98pHVQZXOevon+RCZkXElsRaoQeRzWkAD8Mbpryw9zEC1zjifYoQB+SyhO4Tl1/iiIWoOrxgekRy5CRFADMJR900mdymly4Nr07x5Ckdd6sY1b/aWxHfludFc3T81iWVdvs5ADMIpfJAHzRm9ISavR8rDfFgZioHyuU9t+ZXlZMtMhgSSDNp2wLilB9BG+cg6b3123pL0Z/7cGQcj47t1tCMAAIUdSrgXVizu0kEmS3jtrj33GQPSxmzCzcN/z+9RSggNZNZWd1SJPOy54BPNtIwuGumeANc03KmWU+yhGBIoml4I/NtL/XjBflQBYAmytjOxtG5GML16wF97u6eGV+Q4C7DeRM0GinPxyH10Nxg2zwkYFH00CBbb9Rw7A9KL0RMc+TASm+EQSxQb/c8fAdYZ6KTTE21fPM4sODWz1hehU+Q7jvt+DVYanhFinTe0lmrcHOA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e22426-4346-4888-24f4-08d77e3430c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 12:18:11.5351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oq4WI1EBobIWt16BraipRO4CHCoJQQDIfe2dYBfbrv66pKKutixPAmK3HatQuhL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============1323120479=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1323120479==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB42855499B960506C3BA62198F65A0MN2PR12MB4285namp_"

--_000_MN2PR12MB42855499B960506C3BA62198F65A0MN2PR12MB4285namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I tried your new patches to run BACO for about 10 loops and the result look=
s positive, without observing enter/exit baco message failure again.

The time interval between BACO entries or exits in my environment was almos=
t less than 10 us: max 36us, min 2us. I think it's safe enough according to=
 the sample data we collected in both sides.

And it looks not necessary to continue using system_highpri_wq any more bec=
ause we require all the nodes enter or exit at the same time, while do not =
mind how long the time interval is b/t enter and exit. The system_unbound_w=
q can satisfy our requirement here since it wakes different CPUs up to work=
 at the same time.

Regards,
Ma Le

From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Sent: Wednesday, December 11, 2019 3:56 AM
To: Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.=
Zhou1@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis =
<Dennis.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support fo=
r XGMI


I switched the workqueue we were using for xgmi_reset_work from system_high=
pri_wq to system_unbound_wq - the difference is that workers servicing the =
queue in system_unbound_wq are not bounded to specific CPU and so the reset=
 jobs for each XGMI node are getting scheduled to different CPU while syste=
m_highpri_wq is a bounded work queue. I traced it as bellow for 10 consecut=
ive times and didn't see errors any more. Also the time diff between BACO e=
ntries or exits was never more then around 2 uS.

Please give this updated patchset a try

   kworker/u16:2-57    [004] ...1   243.276312: trace_code: func: vega20_ba=
co_set_state, line 91 <----- - Before BEACO enter
           <...>-60    [007] ...1   243.276312: trace_code: func: vega20_ba=
co_set_state, line 91 <----- - Before BEACO enter
   kworker/u16:2-57    [004] ...1   243.276384: trace_code: func: vega20_ba=
co_set_state, line 105 <----- - After BEACO enter done
           <...>-60    [007] ...1   243.276392: trace_code: func: vega20_ba=
co_set_state, line 105 <----- - After BEACO enter done
   kworker/u16:3-60    [007] ...1   243.276397: trace_code: func: vega20_ba=
co_set_state, line 108 <----- - Before BEACO exit
   kworker/u16:2-57    [004] ...1   243.276399: trace_code: func: vega20_ba=
co_set_state, line 108 <----- - Before BEACO exit
   kworker/u16:3-60    [007] ...1   243.288067: trace_code: func: vega20_ba=
co_set_state, line 114 <----- - After BEACO exit done
   kworker/u16:2-57    [004] ...1   243.295624: trace_code: func: vega20_ba=
co_set_state, line 114 <----- - After BEACO exit done

Andrey
On 12/9/19 9:45 PM, Ma, Le wrote:

[AMD Official Use Only - Internal Distribution Only]

I'm fine with your solution if synchronization time interval satisfies BACO=
 requirements and loop test can pass on XGMI system.

Regards,
Ma Le

From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com><mailto:Andrey.Grodzovs=
ky@amd.com>
Sent: Monday, December 9, 2019 11:52 PM
To: Ma, Le <Le.Ma@amd.com><mailto:Le.Ma@amd.com>; amd-gfx@lists.freedesktop=
.org<mailto:amd-gfx@lists.freedesktop.org>; Zhou1, Tao <Tao.Zhou1@amd.com><=
mailto:Tao.Zhou1@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com><m=
ailto:Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com><mailto:Den=
nis.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com><mailto:Hawking.Zhan=
g@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com><mailto:Guchun.Chen@amd.com>
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support fo=
r XGMI


Thanks a lot Ma for trying - I think I have to have my own system to debug =
this so I will keep trying enabling XGMI - i still think the is the right a=
nd the generic solution for multiple nodes reset synchronization and in fac=
t the barrier should also be used for synchronizing PSP mode 1 XGMI reset t=
oo.

Andrey
On 12/9/19 6:34 AM, Ma, Le wrote:

[AMD Official Use Only - Internal Distribution Only]

Hi Andrey,

I tried your patches on my 2P XGMI platform. The baco can work at most time=
, and randomly got following error:
[ 1701.542298] amdgpu: [powerplay] Failed to send message 0x25, response 0x=
0

This error usually means some sync issue exist for xgmi baco case. Feel fre=
e to debug your patches on my XGMI platform.

Regards,
Ma Le

From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com><mailto:Andrey.Grodzovs=
ky@amd.com>
Sent: Saturday, December 7, 2019 5:51 AM
To: Ma, Le <Le.Ma@amd.com><mailto:Le.Ma@amd.com>; amd-gfx@lists.freedesktop=
.org<mailto:amd-gfx@lists.freedesktop.org>; Zhou1, Tao <Tao.Zhou1@amd.com><=
mailto:Tao.Zhou1@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com><m=
ailto:Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com><mailto:Den=
nis.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com><mailto:Hawking.Zhan=
g@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com><mailto:Guchun.Chen@amd.com>
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support fo=
r XGMI


Hey Ma, attached a solution - it's just compiled as I still can't make my X=
GMI setup work (with bridge connected only one device is visible to the sys=
tem while the other is not). Please try it on your system if you have a cha=
nce.

Andrey
On 12/4/19 10:14 PM, Ma, Le wrote:

AFAIK it's enough for even single one node in the hive to to fail the enter=
 the BACO state on time to fail the entire hive reset procedure, no ?
[Le]: Yeah, agree that. I've been thinking that make all nodes entering bac=
o simultaneously can reduce the possibility of node failure to enter/exit B=
ACO risk. For example, in an XGMI hive with 8 nodes, the total time interva=
l of 8 nodes enter/exit BACO on 8 CPUs is less than the interval that 8 nod=
es enter BACO serially and exit BACO serially depending on one CPU with yie=
ld capability. This interval is usually strict for BACO feature itself. Any=
way, we need more looping test later on any method we will choose.

Any way - I see our discussion blocks your entire patch set - I think you c=
an go ahead and commit yours way (I think you got an RB from Hawking) and I=
 will look then and see if I can implement my method and if it works will j=
ust revert your patch.

[Le]: OK, fine.

Andrey

--_000_MN2PR12MB42855499B960506C3BA62198F65A0MN2PR12MB4285namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">I =
tried your new patches to run BACO for about 10 loops and the result looks =
positive, without observing enter/exit baco message failure again.<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Th=
e time interval between BACO entries or exits in my environment was almost =
less than 10 us: max 36us, min 2us. I think it&#8217;s safe enough accordin=
g to the sample data we collected in both
 sides.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">An=
d it looks not necessary to continue using system_highpri_wq any more becau=
se we require all the nodes enter or exit at the same time, while do not mi=
nd how long the time interval is b/t
 enter and exit. The </span>system_unbound_wq can satisfy our requirement h=
ere since it wakes different CPUs up to work at the same time.<span style=
=3D"font-size:12.0pt;color:windowtext"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Re=
gards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Ma=
 Le<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext"><o=
:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@=
amd.com&gt;
<br>
<b>Sent:</b> Wednesday, December 11, 2019 3:56 AM<br>
<b>To:</b> Ma, Le &lt;Le.Ma@amd.com&gt;; amd-gfx@lists.freedesktop.org; Zho=
u1, Tao &lt;Tao.Zhou1@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher=
@amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Zhang, Hawking &lt;Hawk=
ing.Zhang@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset sup=
port for XGMI<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p>I switched the workqueue we were using for xgmi_reset_work from system_h=
ighpri_wq to system_unbound_wq - the difference is that workers servicing t=
he queue in system_unbound_wq are not bounded to specific CPU and so the re=
set jobs for each XGMI node are
 getting scheduled to different CPU while system_highpri_wq is a bounded wo=
rk queue. I traced it as bellow for 10 consecutive times and didn't see err=
ors any more. Also the time diff between BACO entries or exits was never mo=
re then around 2 uS.
<o:p></o:p></p>
<p>Please give this updated patchset a try<o:p></o:p></p>
<p>&nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 2=
43.276312: trace_code: func: vega20_baco_set_state, line 91 &lt;----- - Bef=
ore BEACO enter<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;...&gt;-60=
&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.276312: trace_code: func: veg=
a20_baco_set_state, line 91 &lt;----- - Before BEACO enter<br>
&nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.=
276384: trace_code: func: vega20_baco_set_state, line 105 &lt;----- - After=
 BEACO enter done<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;...&gt;-60=
&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.276392: trace_code: func: veg=
a20_baco_set_state, line 105 &lt;----- - After BEACO enter done<br>
&nbsp;&nbsp; kworker/u16:3-60&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.=
276397: trace_code: func: vega20_baco_set_state, line 108 &lt;----- - Befor=
e BEACO exit<br>
&nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.=
276399: trace_code: func: vega20_baco_set_state, line 108 &lt;----- - Befor=
e BEACO exit<br>
&nbsp;&nbsp; kworker/u16:3-60&nbsp;&nbsp;&nbsp; [007] ...1&nbsp;&nbsp; 243.=
288067: trace_code: func: vega20_baco_set_state, line 114 &lt;----- - After=
 BEACO exit done<br>
&nbsp;&nbsp; kworker/u16:2-57&nbsp;&nbsp;&nbsp; [004] ...1&nbsp;&nbsp; 243.=
295624: trace_code: func: vega20_baco_set_state, line 114 &lt;----- - After=
 BEACO exit done<o:p></o:p></p>
<p>Andrey<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">On 12/9/19 9:45 PM, Ma, Le wrote:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">I&=
#8217;m fine with your solution if synchronization time interval satisfies =
BACO requirements and loop test can pass on XGMI system.</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">&n=
bsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Re=
gards,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Ma=
 Le</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">&n=
bsp;</span><o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Grodzovsky, Andrey
<a href=3D"mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&=
gt;</a> <br>
<b>Sent:</b> Monday, December 9, 2019 11:52 PM<br>
<b>To:</b> Ma, Le <a href=3D"mailto:Le.Ma@amd.com">&lt;Le.Ma@amd.com&gt;</a=
>; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a>; Zhou1, Tao <a href=3D"mailto:Tao.Zhou1@a=
md.com">
&lt;Tao.Zhou1@amd.com&gt;</a>; Deucher, Alexander <a href=3D"mailto:Alexand=
er.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis <a href=3D"mailto:Dennis.=
Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>; Zhang, Hawking
<a href=3D"mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><=
br>
<b>Cc:</b> Chen, Guchun <a href=3D"mailto:Guchun.Chen@amd.com">&lt;Guchun.C=
hen@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset sup=
port for XGMI</span><o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p>Thanks a lot Ma for trying - I think I have to have my own system to deb=
ug this so I will keep trying enabling XGMI - i still think the is the righ=
t and the generic solution for multiple nodes reset synchronization and in =
fact the barrier should also be
 used for synchronizing PSP mode 1 XGMI reset too.<o:p></o:p></p>
<p>Andrey<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">On 12/9/19 6:34 AM, Ma, Le wrote:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Hi=
 Andrey,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">&n=
bsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">I =
tried your patches on my 2P XGMI platform. The baco can work at most time, =
and randomly got following error:</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
12.0pt;color:windowtext">[ 1701.542298] amdgpu: [powerplay] Failed to send =
message 0x25, response 0x0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">&n=
bsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Th=
is error usually means some sync issue exist for xgmi baco case. Feel free =
to debug your patches on my XGMI platform.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">&n=
bsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Re=
gards,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Ma=
 Le</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">&n=
bsp;</span><o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Grodzovsky, Andrey
</span><a href=3D"mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@a=
md.com&gt;</a><span style=3D"color:windowtext">
<br>
<b>Sent:</b> Saturday, December 7, 2019 5:51 AM<br>
<b>To:</b> Ma, Le </span><a href=3D"mailto:Le.Ma@amd.com">&lt;Le.Ma@amd.com=
&gt;</a><span style=3D"color:windowtext">;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:windowtext">; Zhou1, Tao
</span><a href=3D"mailto:Tao.Zhou1@amd.com">&lt;Tao.Zhou1@amd.com&gt;</a><s=
pan style=3D"color:windowtext">; Deucher, Alexander
</span><a href=3D"mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@a=
md.com&gt;</a><span style=3D"color:windowtext">; Li, Dennis
</span><a href=3D"mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a><s=
pan style=3D"color:windowtext">; Zhang, Hawking
</span><a href=3D"mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&g=
t;</a><span style=3D"color:windowtext"><br>
<b>Cc:</b> Chen, Guchun </span><a href=3D"mailto:Guchun.Chen@amd.com">&lt;G=
uchun.Chen@amd.com&gt;</a><span style=3D"color:windowtext"><br>
<b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset sup=
port for XGMI</span><o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p>Hey Ma, attached a solution - it's just compiled as I still can't make m=
y XGMI setup work (with bridge connected only one device is visible to the =
system while the other is not). Please try it on your system if you have a =
chance.
<o:p></o:p></p>
<p>Andrey<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">On 12/4/19 10:14 PM, Ma, Le wrote:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p>AFAIK it's enough for even single one node in the hive to to fail the en=
ter the BACO state on time to fail the entire hive reset procedure, no ?<o:=
p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:12.0pt;color:#203864">[Le]: Yeah, agree t=
hat. I&#8217;ve been thinking that make all nodes entering baco simultaneou=
sly can reduce the possibility of node failure
 to enter/exit BACO risk. For example, in an XGMI hive with 8 nodes, the to=
tal time interval of 8 nodes enter/exit BACO on 8 CPUs is less than the int=
erval that 8 nodes enter BACO serially and exit BACO serially depending on =
one CPU with yield capability. This
 interval is usually strict for BACO feature itself. Anyway, we need more l=
ooping test later on any method we will choose.</span><o:p></o:p></p>
<p>Any way - I see our discussion blocks your entire patch set - I think yo=
u can go ahead and commit yours way (I think you got an RB from Hawking) an=
d I will look then and see if I can implement my method and if it works wil=
l just revert your patch.<o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:#203864">[Le]: OK, fine.</span><o:=
p></o:p></p>
<p>Andrey<o:p></o:p></p>
</blockquote>
</blockquote>
</blockquote>
</div>
</body>
</html>

--_000_MN2PR12MB42855499B960506C3BA62198F65A0MN2PR12MB4285namp_--

--===============1323120479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1323120479==--
