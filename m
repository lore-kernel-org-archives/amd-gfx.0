Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7880AC87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 13:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E5910E768;
	Wed,  6 Aug 2025 13:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q7BOkfBo";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF3910E768
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 13:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6h/N1Je/AWvjRdI80hAVB3OqgfVLKlF9EVol879fOpcN18iJ3vpJAlSn4nOlU9UjC7/D/ZDFLtz3Q3ugofUtynz+3oQxshuhg+XN+PtjfZP5eyiSQtCV5RobLr+gET/2ZUbZv9IDBFTL857DVScgEqBTAK+z+hL11by54SFaPpJzj6yHnq1WIUuDRWpfFRzhdXKBkxDXRsoEXYwaiHGs+/wNoWf2I8ZZq4HW8fabFeMtyn2KphmCvIKsfqwxfsWEuAxcx4xAZBQAZ484rXMDpAvpjKsVNcI98jZ3vLK1J50kpigpuVGGUXQoX1TBc2UZbCHR/Ps7iiEa9NvLNXL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBHOQVs+dVSF20kadkua1IXeexEezDhc4ETJZtnL03Q=;
 b=Q9blHzz5zAnLPIGmki6x/5euEEjVlr3PabZXHUtJNu2QYPs+zu9uCiDERlxB+IbW1l51kaL9GAqzIWjicwNyRU9k/o5C6YxloqfOqwpffz0WEvWI+3j7C6dBuX9XPgbQAccbd7MM6OBYz1VDY2iFPHVpEpSz0OJjZOzqiDw+3YxNtZpMgUryKc/PcH/tTvESocRkbm8wLLqqZTc4xDV5U5xYV1ST9kxyy6waZygbmwfFqfLG0cSv4BSnBS2UxiZPDpj/am8VXEfL0yBO2Tgt8oaxox5JkB6RTS/xvzheNqFSfaEV6FX1ODoT4zXB2roOpekKSujaL3dJel6Ih07aZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBHOQVs+dVSF20kadkua1IXeexEezDhc4ETJZtnL03Q=;
 b=q7BOkfBo3G+Uy5opeZJJjLFZ9QsiX74F+6FCmex/j+XaZwucPTXxEjGl9SGjRlT7XfoqjgntWi3J8BX30WFoWfygQDe0NLUjgHiUho6FgPHk8eTlzYNEiUwaRZi6pbW/52aJ/Wf2hqJUhjuq+oVgaLuoLVukiJlczWL+tIuhnn0=
Received: from PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 13:07:09 +0000
Received: from PH7PR12MB6934.namprd12.prod.outlook.com
 ([fe80::81c:7e78:f745:d2b4]) by PH7PR12MB6934.namprd12.prod.outlook.com
 ([fe80::81c:7e78:f745:d2b4%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 13:07:09 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add PSP fw version check for fw reserve GFX
 command
Thread-Topic: [PATCH] drm/amdgpu: Add PSP fw version check for fw reserve GFX
 command
Thread-Index: AdwG0wC+py0ihZ1LSMOlNG6CWeWPuA==
Date: Wed, 6 Aug 2025 13:07:09 +0000
Message-ID: <PH7PR12MB69348D15141806A2D30FE097E92DA@PH7PR12MB6934.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-06T13:04:40.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6934:EE_|SA0PR12MB7003:EE_
x-ms-office365-filtering-correlation-id: 64f66d7f-d10f-47c8-7c87-08ddd4ea26b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?hv77AajCUnEhw50mOl68gePVGMI3GDonzn+NxnlrswKEX74hkAwKgIZraiPX?=
 =?us-ascii?Q?OdZgXzq0iyrIJHEmStJvoT21UjHxOhRyK0P92CyAXTMRh/S7H+YTuDPVemnf?=
 =?us-ascii?Q?ividFEiQ398iWU+JDWj8lTrIbDE5dVCsc/QM/bNC6JWTAN0Ezg63e4NBz7gy?=
 =?us-ascii?Q?ERPtBkDbXv+oPvDj7969WO+b0CvAaz1fM7lX6J/E20SIjIKu6thZPBDKOKIk?=
 =?us-ascii?Q?AbjyXZ/sP+0dYBOgdtUu+vm3YuGi73Ifr9O20tTeZaB0OaCX83qzPEGkNc9s?=
 =?us-ascii?Q?csSzzOQ7NX94TQVakKHfUU6+TJwML1hmNjnQb1B6BIHAM4+nzITRLQExiCzC?=
 =?us-ascii?Q?qzJMXU83VXcZKyChDqvaPSeAX7nCW7wcoeuTGXA7Qb9GEToxnoWhQ1OmNSE6?=
 =?us-ascii?Q?JsefVw1cvaYOYDaWzgnCTnzuuuOybNC2YI4UCGGCDtkLrvmSHCIIpvlrZuod?=
 =?us-ascii?Q?URqM5Er4Y3jI8WJVS38VegauQcLrqxAtj3pLKLstfiFeP6SYank12hAE2DVV?=
 =?us-ascii?Q?4r11B5dsa/dDsTpo2x1z6xKlo1zpmlpH2hBmHW/jJFwer6B6m+d7+PCsGab1?=
 =?us-ascii?Q?GeB36ZaLeUdIcdq2iKYNm4DGWcPv3GbJSDzRHsEchmfUQ25cGzRBy19jTBSU?=
 =?us-ascii?Q?cxhC6auuB7O5FqREA4fmYxWS8ik6eOqvDdO7qm+vVjxJKbl4gjDO32FKSM6g?=
 =?us-ascii?Q?kNrIMo2ALdzJYsMYPkq32Ips808LD+f2ZvNPPZnF1//TQmJkp8woiC80cH7c?=
 =?us-ascii?Q?WL5xJMq7+afzQWIf09NVPjHWgoeDZYtOIPgaz6a/vy3C8OZc3HVxckB92K2u?=
 =?us-ascii?Q?ha8hWLkCmoWoXMJGFJJS/zv+GXN8cxZ652Zfcz0f7c2fXA7eyCu73/8GqSch?=
 =?us-ascii?Q?WSQnCJ4F3+vUfC30LNPMdTrIHIjYszLsVGvWY1tGIs/gOTROGTH9RN4S6zxT?=
 =?us-ascii?Q?pSqOyWNDtLF5fnrq2d06HXHz+cotoPcNj0egbcrHTYYpdlsVZ16aK1u7G4kI?=
 =?us-ascii?Q?bCvIBTb4gUzT5phnZcqvs/akZmFWVoTEih/I2i8FniDuD84rJtxK1p0Sm3rF?=
 =?us-ascii?Q?p8I7dgCPvsN3CGlFd4IQHo8CypgAjtvOix+R4fdJbOuv7R9+2A7fBwYSaTf/?=
 =?us-ascii?Q?qjFB0+m7tM4NH3yhBtANIEUfuG1yxFhpRhvs5b6kmyaqZnSBoMrhBdtqOq2z?=
 =?us-ascii?Q?Wrd8+M0jw+W2ec7qEgEEDTHDFAWeMhfdoi+23N4mpJWFnutU/UL3A/j85Pye?=
 =?us-ascii?Q?pnp23cL7/H2iIMKi8xt+FAJZWadoc1DGrt9xmHph6kMQhoZC5nMwqoVDPM0m?=
 =?us-ascii?Q?CTnsCgriJUtoajaV7dQXbsLqTHtK45dPuo+Xsle+hSPw9EkZT4anmHCp40Xd?=
 =?us-ascii?Q?948HLjf5b2rH450m63Qfl1bXQSKdCecAQWgNEJJFF5eESkyOGDEY8Ebf+8WE?=
 =?us-ascii?Q?BqfTUf8WyseMrjaIXhA2mWZaKvlZkblu7ZGpf+Zyrqlz6oIVbb+dHA1v/6x9?=
 =?us-ascii?Q?uGVDj22sCDTBKic=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6934.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pENF7Grr7Mlc1dwyK/dl8k6Wa3VPQWlNfWG+dSLtOhCRKCiOa2/eR+xdIJSN?=
 =?us-ascii?Q?9Ao6RcnuMB78lTG4T9/cBC2fzt2YDlzdqoVrsFtXFMZkBDZhBlQMmWBw36cx?=
 =?us-ascii?Q?BrbcUEtyHK6BVyREHQJc9N72jxzbqeexaJYseuwtL7aaJk+nFvIl00jj7/z3?=
 =?us-ascii?Q?R8CFbuCPEaWR9tDRK3XsQ+mxUJJcDHPFefKS/CJP6QAW76nWljIbd/VmReF/?=
 =?us-ascii?Q?ZtSCZyR2SOhbWiZP5TXXZ7B+S6P9YoNMlsuhD7Q6j+Ng5/3wzrg28rmzQ5hz?=
 =?us-ascii?Q?SZPpleJVqkPOXXNu7tS/o0STEimnq2/YkD9Jh72NfqX5wJN7P50Dfo2Kd3E4?=
 =?us-ascii?Q?cvGYso5XQQzwzinMGtfzW+c5H/re9yLQQ7kkD8Iz0/zhFhZDFsAJumCmk9gF?=
 =?us-ascii?Q?fZgi3KJNFHDteuQVLaK96e0RqZpMSgzwMTCDKWOX8Km6XQXnXFoKK57VB+MY?=
 =?us-ascii?Q?YHy5Tt0bYbxTHr5vzkZK/UC/zpT/cerKY26gTrJ24p5ldsqN50MA4lWKs6xb?=
 =?us-ascii?Q?/WMs6MSs7r1AtW+yBMS72Hucx/Vwg+gNhVi7xq6rzg89t0NcJOD1CImfKYuw?=
 =?us-ascii?Q?FUpaNspFnhi5VVZVLyhyOBHdoFC3HwHknwl5u0nJkUdG3mVu92zc1E6mi/Q+?=
 =?us-ascii?Q?Sw+qIP5Ax1A4/HDF/azEMJZLf6HjuynNo/2WwGuzMT1HJqdmnyIFHmTo7r/y?=
 =?us-ascii?Q?V4mOD1gAhCQQ0RW8uMEkcb0l7UloxoZ+6XYQlB7zRDIiyrN5e66RlwD634fg?=
 =?us-ascii?Q?NTBW1GQBmW5mmEkU3rozs1J7TpKHefe38L3Zopeyg6QL1qKH6QQw36j03ckk?=
 =?us-ascii?Q?JN5vUAETFEj2wKkqQqD8341JV4Ue0FvBerxL30GHM04h0niKTevbwiZZK+50?=
 =?us-ascii?Q?o3nzuxHzZMrQ7bQaxuxv9pob5Uy/ylSNi+GQsN667Pj1pD2zbexiH1YCjDhE?=
 =?us-ascii?Q?goBh0ix5tJz5XnWmI1oMWMPCl3eDvsSMN8BanY5kpXHx04z7uwqxzBnRQ/42?=
 =?us-ascii?Q?XVaCkn1qn6fKQGvkiAQtHtDnguH/bQAZcsA9qEETEqno0WXQeQCfewjlkXyP?=
 =?us-ascii?Q?YmImcC7QPoTKxAyreFX00SDrPeBxlu9xn+hUi6+vofb8tkuuP0PJbBG5arFQ?=
 =?us-ascii?Q?RJfwUcBgzz7Vr+7MiCk215WQenx89zf/kAYmUD6DJ4nKKy37uKA1cBoIfANk?=
 =?us-ascii?Q?z6AOKiZMEgh6m7NSGTW8/vpRipt6z1ukeznuJYEhJUqUtVRVnrUn0AxvUyBh?=
 =?us-ascii?Q?MoA/+650yN10jB4nHCgOywH+CWe0KndJAL69vajXYA9psnbWuO0u1zDbQ6hW?=
 =?us-ascii?Q?yJNEPl0SNJ9mC067Wm4Nk+JmvBxJ6hbklVg/X3oz47udD3jbHSzxYTRKQQNm?=
 =?us-ascii?Q?uBLG1RbMotxDoeMw7A4/3w/jqgvvb/sMZu2mlOnimOJsWpShXtZCn0o1AUnu?=
 =?us-ascii?Q?mbTtPdY4FGAmVaASAtAB4deuZH5rCwPBVoau3vDkR7xNvzHg/vmSQsowytRI?=
 =?us-ascii?Q?K2ZckdK/zfDUwldMTKVmcEKIXSPHUvDo6EjkXayEc+aMy85xC/W5QwTPu4Fi?=
 =?us-ascii?Q?A4fKEuZNc4iJ7CeATaA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB69348D15141806A2D30FE097E92DAPH7PR12MB6934namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6934.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f66d7f-d10f-47c8-7c87-08ddd4ea26b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 13:07:09.3276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLWATV7akMkn3FZ08q6sqWR+TRE5vdBwWhKHehY5rDKBPF1R4g6PJcYGj5K3rEcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003
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

--_000_PH7PR12MB69348D15141806A2D30FE097E92DAPH7PR12MB6934namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


From: Frank Min <Frank.Min@amd.com<mailto:Frank.Min@amd.com>>

Date: Tue, 5 Aug 2025 22:30:54 +0800

Subject: [PATCH] drm/amdgpu: Add PSP fw version check for fw reserve GFX

command



The fw reserved GFX command is only supported starting from PSP fw

version 0x3a0e14 and 0x3b0e0d. Older versions do not support this command.



Add a version guard to ensure the command is only used when the running

PSP fw meets the minimum version requirement.



This ensures backward compatibility and safe operation across fw

revisions.



Signed-off-by: Frank Min <Frank.Min@amd.com<mailto:Frank.Min@amd.com>>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 19 ++++++++++++++++---

1 file changed, 16 insertions(+), 3 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c

index 14121efb9d95..1acc1ffce31d 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

@@ -1043,15 +1043,28 @@ int psp_update_fw_reservation(struct psp_context *p=
sp)

{

        int ret;

        uint64_t reserv_addr, reserv_addr_ext;

-       uint32_t reserv_size, reserv_size_ext;

+       uint32_t reserv_size, reserv_size_ext, mp0_ip_ver;

        struct amdgpu_device *adev =3D psp->adev;



+       mp0_ip_ver =3D amdgpu_ip_version(adev, MP0_HWIP, 0);

+

        if (amdgpu_sriov_vf(psp->adev))

                return 0;



-       if ((amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(14, 0, 2)=
) &&

-           (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(14, 0, 3)=
))

+       switch (mp0_ip_ver) {

+       case IP_VERSION(14, 0, 2):

+               if (adev->psp.sos.fw_version < 0x3b0e0d)

+                       return 0;

+               break;

+

+       case IP_VERSION(14, 0, 3):

+               if (adev->psp.sos.fw_version < 0x3a0e14)

+                       return 0;

+               break;

+

+       default:

                return 0;

+       }



        ret =3D psp_get_fw_reservation_info(psp, GFX_CMD_ID_FB_FW_RESERV_AD=
DR, &reserv_addr, &reserv_size);

        if (ret)

--

2.43.0

--_000_PH7PR12MB69348D15141806A2D30FE097E92DAPH7PR12MB6934namp_
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
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Arial",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Arial",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Arial",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">From: Frank =
Min &lt;<a href=3D"mailto:Frank.Min@amd.com">Frank.Min@amd.com</a>&gt;<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">Date: Tue, 5=
 Aug 2025 22:30:54 +0800<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">Subject: [PA=
TCH] drm/amdgpu: Add PSP fw version check for fw reserve GFX<o:p></o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">command<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">The fw reser=
ved GFX command is only supported starting from PSP fw<o:p></o:p></span></p=
>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">version 0x3a=
0e14 and 0x3b0e0d. Older versions do not support this command.<o:p></o:p></=
span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">Add a versio=
n guard to ensure the command is only used when the running<o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">PSP fw meets=
 the minimum version requirement.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">This ensures=
 backward compatibility and safe operation across fw<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">revisions.<o=
:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">Signed-off-b=
y: Frank Min &lt;<a href=3D"mailto:Frank.Min@amd.com">Frank.Min@amd.com</a>=
&gt;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">---<o:p></o:=
p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">drivers/gpu/=
drm/amd/amdgpu/amdgpu_psp.c | 19 ++++++++++++++++---<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">1 file chang=
ed, 16 insertions(+), 3 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">diff --git a=
/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_psp.c<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">index 14121e=
fb9d95..1acc1ffce31d 100644<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">--- a/driver=
s/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+++ b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">@@ -1043,15 =
+1043,28 @@ int psp_update_fw_reservation(struct psp_context *psp)<o:p></o:=
p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">{<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t reserv_addr, reserv_addr_ext;<o:p><=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">-&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserv_size, reserv_size_ext;<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserv_size, reserv_size_ext, mp0_ip_ver=
;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D psp-&gt;adev;=
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; mp0_ip_ver =3D amdgpu_ip_version(adev, MP0_HWIP, =
0);<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">-&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP=
_VERSION(14, 0, 2)) &amp;&amp;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">-&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, =
MP0_HWIP, 0) !=3D IP_VERSION(14, 0, 3)))<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; switch (mp0_ip_ver) {<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(14, 0, 2):<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (adev-&gt;psp.sos.fw_version &lt; 0x3b0e0d)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span><=
/p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(14, 0, 3):<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (adev-&gt;psp.sos.fw_version &lt; 0x3a0e14)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span><=
/p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_get_fw_reservation_info(psp, GFX=
_CMD_ID_FB_FW_RESERV_ADDR, &amp;reserv_addr, &amp;reserv_size);<o:p></o:p><=
/span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">--<o:p></o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">2.43.0<o:p><=
/o:p></span></p>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB69348D15141806A2D30FE097E92DAPH7PR12MB6934namp_--
