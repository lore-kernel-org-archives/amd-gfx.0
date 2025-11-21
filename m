Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE72CFC266
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 11:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4082210E859;
	Fri, 21 Nov 2025 11:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Onk85Bn/";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8D710E859
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 11:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8gDMOxqp4CiDOTIXJNy5QdReJ4KHk/EAOymgT7A/8bb624D43unD0OhFSLVVX3kibKZ2fXD/c9b8ljfMUYesGoV/vmvaM4dS3z0Pm4xB3PYEj32naFVHrzZmOwbjmvs1pAzmBKPGvfW6SwY+TavoOeOy/JrJEHBrlRh5ypnxCcTGRx6lyVpQU7VwtQ+beImH1yE3xh0f+nb3/Najj2ui4Yrnpt8IRPNZCVdobC1w/UpkV6yj4WQlY/as3D1bOVZsJQhr0HSQchTXzaLLtQNHz8hlIIAqmp+7bAw7Z7t6JaKfI1r5u0EceLz5kp3jOLX9LBoVN0N0DRC8IPWPPhEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndpptDdu7zmTUnbW/uIn8I9R9xG3rZF2WlZiFEA8rUk=;
 b=tKaupy37eWe1w21j0Uqut52A6C+BxZOeRI7T3Azf0NXq6DoL8zM/+lwNuhgNd5BbG8ivkTs8tjZSL3+vcINqUzXS98FZ0VHMz44TnwTLNkhl24YTuvfXi79MIEz7u/EEoQfraqSa2yy1nk9d4xdFshBRBJUAFR8apruX2v5b2b+J3V8rSLiNaS1624r9Wk+YNX5lXot5b/ouA4g40pUcpaDo/KLbhlXXG16Idwe3NJcJmARAGQgWtO6oieJ3HumUhe+g26oj9BnIiXtsf5cp6RJPTihd6oThcIm/5SRq0/ubINKTIqZJl1fdhFhVwgAl1uKmVOBvJ+onPdqbsqSwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndpptDdu7zmTUnbW/uIn8I9R9xG3rZF2WlZiFEA8rUk=;
 b=Onk85Bn/gepUPJaWbKfQOaut8CWBrn7VppvooX0dUeVOY1Wykdqm3FiaxgDArxXGya16uQnRXlDrDTW3eKmOPcZo2PKPeuWgcxTMgeG4NRs58bmxlHIJpsYQgoiomwuc5HM4MPCmKl9hL4IEGIFo2gZ1LNXrzFR2FCa5/HGp83E=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Fri, 21 Nov
 2025 11:31:16 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b%6]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 11:31:16 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: Re: [bug report] drm/amd/ras: Add CPER ring read for uniras
Thread-Topic: [bug report] drm/amd/ras: Add CPER ring read for uniras
Thread-Index: AQHcWsOXPoibIkq/TUC/GmnuuV8KkbT8/Z+l
Date: Fri, 21 Nov 2025 11:31:16 +0000
Message-ID: <CY5PR12MB63454C81432E0C3BEE31648BFAD5A@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <aSAbtCGcXRqNRFq0@stanley.mountain>
In-Reply-To: <aSAbtCGcXRqNRFq0@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-21T11:31:15.982Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|DM6PR12MB4155:EE_
x-ms-office365-filtering-correlation-id: 5073e95e-daa1-4d93-b6aa-08de28f17bd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Khexz0pg6wtIx/BoSRfqdK/acwpNOPGQ5UK+aXQezWLtSP+73wgd1TmRrw4K?=
 =?us-ascii?Q?TsUf0JveU0wviuiVfUhuBh4xBgzsJAbdlOKZTuBKUtV6ndnjyH0YlrtT3VQA?=
 =?us-ascii?Q?DOpY141Prfw8ZgWVRiAe2k1JHDw3UkwqxiPGmc3Juy/pYt1da70CfBFMhn8D?=
 =?us-ascii?Q?zilCUa/a+zbx6o1RoIMLpg4N6XBVR8xMSFBmSJXT97Hy1JEeJeemA22c+57H?=
 =?us-ascii?Q?eMqAqXPHrdq5HC6CVmlkiYwysA4BCLQyKA8WnJi6jF8qBS6234O2zgd7+ibK?=
 =?us-ascii?Q?At1NJyegvcAm+56vqc8OCbK58AWNuU47X/msLALyMSDXUIVfjuajEyf/v91B?=
 =?us-ascii?Q?StsTMDJRQ63TQ/30qFajhsm/4P+JDmG5LZywjEq1wevUwn/yx8pp5Ka4gfxE?=
 =?us-ascii?Q?/+5vOMrfx9xZdKXK7TqNtQdZdXDOzb/FQ7dcJu6M9EM0FEKN00S/WVep+Vrl?=
 =?us-ascii?Q?rjui7j+x8uAg4GuMoH7uIWE1PeQIPnF/WDqAtTXaEzY6gEXtdKk87PfionY7?=
 =?us-ascii?Q?8vmpbHepbMOQHwFrEl6LJZjrKH6NhqwskkP3vLNS9b8zZnwPURp/v9UV/zRt?=
 =?us-ascii?Q?Z63KZ2CIhlfH+ZSzRBVLuly4pX5wGiwBzj/cD3ZlxkxPferAAeJPeSjZY30i?=
 =?us-ascii?Q?baqAT6LJ0hsG72aK10SfcBm4sNVwO9GyWYZ6PTAA+nEzHtyBll+OGe5inw+M?=
 =?us-ascii?Q?Be8YzeKpCCtouC2vAVRhUeHNjvG0ue/NEz6Gayqf1uMyNiJofrHLm/H4dtSv?=
 =?us-ascii?Q?Y/SpNFHXFgaxlpHCuUnvDc2n4QtTxzWPbLmOuowM4qkf1HL2E1OtFiBTvVu7?=
 =?us-ascii?Q?W6ejO6VKTOBJKxQStL8v+zQrTfXE/U3gPGcEmDW2GdLg3swr+p0PRm6BVnRr?=
 =?us-ascii?Q?lVO9UQpkjRgC5c4cWkg+RDkBNsCDUL4lUBRKg9kM9bItbvuNMbE5Hy5xwNOb?=
 =?us-ascii?Q?rK1xMDB194BXLHeu7dGX+Q/P/O7PlQse9A07ZgONrX7GqaB1T4EWo0CS+u1O?=
 =?us-ascii?Q?D4lWcb1Ki+6RU3A/3gsR5UPlB231WQ4OYL1Ok/9+Njm1Za6NwOocqII/VRPi?=
 =?us-ascii?Q?D96TtwUS7sHJ1/qrRQY5i+3jrq7AcMfvH0HZm45QyYcxFkZjsfiBl4Js3MOI?=
 =?us-ascii?Q?oj0EG/EuRdkcuO5ucQJYhN+lBe0mwcZ/0RYg9+ALr5h6tAXFA+8SSaF7UyMZ?=
 =?us-ascii?Q?/E3UuxBvWppZw2XSCLXua2CNKQweDeJqqJcFhqh+lAx/Ra0iWAZHioiX2vso?=
 =?us-ascii?Q?N5GAnEzoKCP4KhmRVRsT6aM4IfIJX5z+TOId/nUWT4n4/V5u1uW6HcJLw3D/?=
 =?us-ascii?Q?9iHrPhWU2oa1gZV4HDjctOmE4mC6dHaZkGZ1n1Lbns95Nexe6u7cxMKOpwa4?=
 =?us-ascii?Q?wMqj0eN3hHoJH9lkyyqrZfStt6wGTfE7vF9gItuTpuQ4wEMtaonHZ5CiDxKH?=
 =?us-ascii?Q?x7gl3OvmUplxrepWIurkLMIAkZPLeivfg6WDRG6imwxduI8lTf5TScO9j+NN?=
 =?us-ascii?Q?OBsbEfJBKOHxL8T4BtsHkmdVnYb/APkx+h3T?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M73qR+FMcYhQ5IOZ8NGCnBzlxGhYq/mSpzHa6tCExbCKf/mOxIBlm2CrWnE7?=
 =?us-ascii?Q?wxSxjzrKG6ZFz+OfLwqSM5SU0P4iLzz0t2C7rYoGp42yT5+v+PlUeHV6cHPn?=
 =?us-ascii?Q?CdNYmyeo0yPW2XGx1Bq6hC4NoNFj3aqbKhZlQeuRQpUeLQCt4ScjIi66WR3h?=
 =?us-ascii?Q?nZsNkd8Af4vOGY3eGf2fCW9x7BBUTaNhVy3qaZqjglf/6+11YMci3QBdxaeu?=
 =?us-ascii?Q?vQedKfdvrUSA3TwOOrt3mgH+K2BRmnFR+rYeygq005tnHjE0Ny3WEpMt6VAC?=
 =?us-ascii?Q?z2cDEn+N4gXripaFi2LF4i/Pno0uEGmlmDpizJIKGwMop/KgtAtPzDftzxr2?=
 =?us-ascii?Q?KCXg8kduPtjM6Rhz6Fcs7nQfnyJuagb26FRdS3EAIMzCen8uEUMbywfhR7OX?=
 =?us-ascii?Q?DGqqo1e9ENvqAPp7WNvnY/ElPTvT1Gm2RhAQQnP63DfHFcHjKiQKTIYn0Rfn?=
 =?us-ascii?Q?XGAbXokNgXcP2B1x8cixHM6dfxL3jteConRKSJfuOONjUP0EZj0Y3/tWAKBm?=
 =?us-ascii?Q?jY/X0A3MbycCwtbJ6it3f5vRb9l8+s63MXQEx6c0Fpa6SltclCvDdgEvtpD/?=
 =?us-ascii?Q?74Wf3jWiPY9nSSNg+vAItwfPwExhMEPXjzBWN7mSRCX1uQZDYrQNJ+cRz90Z?=
 =?us-ascii?Q?FCwHCzN8OA1rPpshOTNLV2HJyhzTNgmzuvHa+bqvOVACt4wTHjAgQF2C8enS?=
 =?us-ascii?Q?fC1TzYvRi5xHVhVo77/F1lbMo28bl2CJDc7X/ZYghwbTBebfYPFW9ig9Np8l?=
 =?us-ascii?Q?7tckfx8QuzIZVAhuQdQB+07jCNAS2PkAmGkzYajUWxcQgqUfQZOqv8+kH992?=
 =?us-ascii?Q?vCQxTjZP9iUQdPp3M6lO3ugjS9vfa8+oIHwF+MkJlSg25b/TDa+qzRZKIDZt?=
 =?us-ascii?Q?BOAY2Ap8lVUMujGmo00W9S0wbMyuny5BwjpeyXk2CEbSqLOQtWangrKrRJ4K?=
 =?us-ascii?Q?XslXiju9SKD1j3MkWui6fb2IgrEbQq0vIub+JCgdDj0N/n70JzREKuVcyuoj?=
 =?us-ascii?Q?XgqrVY1KtzCdVPINcStyEaaJ9WBNRO8gDZTyxDmDwsYky3pJS4mVJ0N/GurS?=
 =?us-ascii?Q?V3o68JTo8fASdFFhOsQ1c7070ia6+RjrtBepFMibVJYdxZFCejEv0whM6ivR?=
 =?us-ascii?Q?6snFqXz3SuQkpEEtgBEfcgq0q+nA2if5eNNtQn4m4PJzw4vL/J9k2RYi79fz?=
 =?us-ascii?Q?Jc+FVaZs8ToZbM3PsD+1Jhksirhuiwe5xh8viKTO2RrHcLdeD78dQ/6wDx5l?=
 =?us-ascii?Q?BZbL5sKfhXxQJQWU3IWuKr9eBroiAjV+PRnUP62tYdBxiMvXnUeLzhVL1ahG?=
 =?us-ascii?Q?ua6tpR7+56fSe7F84nMFiSBdp25KVbPKbSKokEUCBHZU3WV20af1GfZzNLH/?=
 =?us-ascii?Q?+Fex3/GiPYusiJOZ5AY45hy9HPQPICnNfRqCwr7T4zzVPWdGLSDgYSnZm2RL?=
 =?us-ascii?Q?q8ewXwLqyWj6zmNC1lXk/atEQX8bliMM1IGTPUHR7qrNjQiNKu/1x9kyde2E?=
 =?us-ascii?Q?RkVbBIT1cIMBtneL8C8AOIIheDofhgyOIVzw9kBcsuXRK/LAwBpEbkuH/rMh?=
 =?us-ascii?Q?/2IgFfMrQC4X5cS03Ks=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63454C81432E0C3BEE31648BFAD5ACY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5073e95e-daa1-4d93-b6aa-08de28f17bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 11:31:16.2799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMRMStGeJhMQjRibn+8ab8mV94TW8UD+2Tacg3NIiF81BD5OMnf+InmylWqsxJ1iIrLX0Tso74z6NCYsLUlaXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

--_000_CY5PR12MB63454C81432E0C3BEE31648BFAD5ACY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hello Dan Carpenter,
Thanks for your reporting. SHANMUGAM, SRINIVASAN has sent the fix patch and=
 it works for me.

Best Regards,

Liu, Xiang

________________________________
From: Dan Carpenter <dan.carpenter@linaro.org>
Sent: Friday, November 21, 2025 3:58 PM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/ras: Add CPER ring read for uniras

Hello Xiang Liu,

Commit 527e3d40339b ("drm/amd/ras: Add CPER ring read for uniras")
from Oct 22, 2025 (linux-next), leads to the following Smatch static
checker warning:

        drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:523 amdgpu_ras_cper_debugf=
s_read()
        warn: userbuf overflow? is 'ring_header_size' <=3D 'size'

drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
    499 static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __=
user *buf,
    500                                             size_t size, loff_t *of=
fset)
    501 {
    502         const uint8_t ring_header_size =3D 12;
    503         struct amdgpu_ring *ring =3D file_inode(f)->i_private;
    504         struct ras_cmd_cper_snapshot_req *snapshot_req __free(kfree=
) =3D
    505                 kzalloc(sizeof(struct ras_cmd_cper_snapshot_req), G=
FP_KERNEL);
    506         struct ras_cmd_cper_snapshot_rsp *snapshot_rsp __free(kfree=
) =3D
    507                 kzalloc(sizeof(struct ras_cmd_cper_snapshot_rsp), G=
FP_KERNEL);
    508         struct ras_cmd_cper_record_req *record_req __free(kfree) =
=3D
    509                 kzalloc(sizeof(struct ras_cmd_cper_record_req), GFP=
_KERNEL);
    510         struct ras_cmd_cper_record_rsp *record_rsp __free(kfree) =
=3D
    511                 kzalloc(sizeof(struct ras_cmd_cper_record_rsp), GFP=
_KERNEL);
    512         uint8_t *ring_header __free(kfree) =3D
    513                 kzalloc(ring_header_size, GFP_KERNEL);
    514         uint32_t total_cper_num;
    515         uint64_t start_cper_id;
    516         int r;
    517
    518         if (!snapshot_req || !snapshot_rsp || !record_req || !recor=
d_rsp ||
    519             !ring_header)
    520                 return -ENOMEM;
    521
    522         if (!(*offset)) {
--> 523                 if (copy_to_user(buf, ring_header, ring_header_size=
))

Technically this should be min(size, ring_header_size) but I haven't
reviewed what other changes might be required here.

    524                         return -EFAULT;
    525                 buf +=3D ring_header_size;
    526         }
    527
    528         r =3D amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
    529                                           RAS_CMD__GET_CPER_SNAPSHO=
T,
    530                                           snapshot_req, sizeof(stru=
ct ras_cmd_cper_snapshot_req),
    531                                           snapshot_rsp, sizeof(stru=
ct ras_cmd_cper_snapshot_rsp));
    532         if (r || !snapshot_rsp->total_cper_num)
    533                 return r;
    534
    535         start_cper_id =3D snapshot_rsp->start_cper_id;
    536         total_cper_num =3D snapshot_rsp->total_cper_num;
    537
    538         record_req->buf_ptr =3D (uint64_t)(uintptr_t)buf;
    539         record_req->buf_size =3D size;
    540         record_req->cper_start_id =3D start_cper_id + *offset;
    541         record_req->cper_num =3D total_cper_num;
    542         r =3D amdgpu_ras_mgr_handle_ras_cmd(ring->adev, RAS_CMD__GE=
T_CPER_RECORD,
    543                                           record_req, sizeof(struct=
 ras_cmd_cper_record_req),
    544                                           record_rsp, sizeof(struct=
 ras_cmd_cper_record_rsp));
    545         if (r)
    546                 return r;
    547
    548         r =3D *offset ? record_rsp->real_data_size : record_rsp->re=
al_data_size + ring_header_size;
    549         (*offset) +=3D record_rsp->real_cper_num;
    550
    551         return r;
    552 }

regards,
dan carpenter

--_000_CY5PR12MB63454C81432E0C3BEE31648BFAD5ACY5PR12MB6345namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
Hello Dan Carpenter,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks for your reporting. SHANMUGAM, SRINIVASAN has sent the fix patch and=
 it works for me.</div>
<p style=3D"direction: ltr; text-align: left; text-indent: 0px; background-=
color: white; margin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof=
">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: black;">Best Regards,</span></p>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: rgb(36, 36, 36);">Liu, Xiang</span></p>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dan Carpenter &lt;dan=
.carpenter@linaro.org&gt;<br>
<b>Sent:</b> Friday, November 21, 2025 3:58 PM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Subject:</b> [bug report] drm/amd/ras: Add CPER ring read for uniras</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello Xiang Liu,<br>
<br>
Commit 527e3d40339b (&quot;drm/amd/ras: Add CPER ring read for uniras&quot;=
)<br>
from Oct 22, 2025 (linux-next), leads to the following Smatch static<br>
checker warning:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgp=
u_ring.c:523 amdgpu_ras_cper_debugfs_read()<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; warn: userbuf overflow? is 'ring=
_header_size' &lt;=3D 'size'<br>
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&nbsp;&nbsp;&nbsp; 499 static ssize_t amdgpu_ras_cper_debugfs_read(struct f=
ile *f, char __user *buf,<br>
&nbsp;&nbsp;&nbsp; 500&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size, =
loff_t *offset)<br>
&nbsp;&nbsp;&nbsp; 501 {<br>
&nbsp;&nbsp;&nbsp; 502&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cons=
t uint8_t ring_header_size =3D 12;<br>
&nbsp;&nbsp;&nbsp; 503&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct amdgpu_ring *ring =3D file_inode(f)-&gt;i_private;<br>
&nbsp;&nbsp;&nbsp; 504&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct ras_cmd_cper_snapshot_req *snapshot_req __free(kfree) =3D<br>
&nbsp;&nbsp;&nbsp; 505&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct ras_cmd_c=
per_snapshot_req), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp; 506&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct ras_cmd_cper_snapshot_rsp *snapshot_rsp __free(kfree) =3D<br>
&nbsp;&nbsp;&nbsp; 507&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct ras_cmd_c=
per_snapshot_rsp), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp; 508&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct ras_cmd_cper_record_req *record_req __free(kfree) =3D<br>
&nbsp;&nbsp;&nbsp; 509&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct ras_cmd_c=
per_record_req), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp; 510&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct ras_cmd_cper_record_rsp *record_rsp __free(kfree) =3D<br>
&nbsp;&nbsp;&nbsp; 511&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct ras_cmd_c=
per_record_rsp), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp; 512&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
8_t *ring_header __free(kfree) =3D<br>
&nbsp;&nbsp;&nbsp; 513&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kzalloc(ring_header_size, GFP_K=
ERNEL);<br>
&nbsp;&nbsp;&nbsp; 514&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t total_cper_num;<br>
&nbsp;&nbsp;&nbsp; 515&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t start_cper_id;<br>
&nbsp;&nbsp;&nbsp; 516&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
r;<br>
&nbsp;&nbsp;&nbsp; 517 <br>
&nbsp;&nbsp;&nbsp; 518&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
!snapshot_req || !snapshot_rsp || !record_req || !record_rsp ||<br>
&nbsp;&nbsp;&nbsp; 519&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; !ring_header)<br>
&nbsp;&nbsp;&nbsp; 520&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;&nbsp;&nbsp; 521 <br>
&nbsp;&nbsp;&nbsp; 522&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
!(*offset)) {<br>
--&gt; 523&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_to_user(buf, ring_header, ring_hea=
der_size))<br>
<br>
Technically this should be min(size, ring_header_size) but I haven't<br>
reviewed what other changes might be required here.<br>
<br>
&nbsp;&nbsp;&nbsp; 524&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return -EFAULT;<br>
&nbsp;&nbsp;&nbsp; 525&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf +=3D ring_header_size;<br>
&nbsp;&nbsp;&nbsp; 526&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&nbsp;&nbsp;&nbsp; 527 <br>
&nbsp;&nbsp;&nbsp; 528&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_ras_mgr_handle_ras_cmd(ring-&gt;adev,<br>
&nbsp;&nbsp;&nbsp; 529&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RAS_CMD__GET_CPER_SNAPSHO=
T,<br>
&nbsp;&nbsp;&nbsp; 530&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snapshot_req, sizeof(stru=
ct ras_cmd_cper_snapshot_req),<br>
&nbsp;&nbsp;&nbsp; 531&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snapshot_rsp, sizeof(stru=
ct ras_cmd_cper_snapshot_rsp));<br>
&nbsp;&nbsp;&nbsp; 532&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
r || !snapshot_rsp-&gt;total_cper_num)<br>
&nbsp;&nbsp;&nbsp; 533&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp; 534 <br>
&nbsp;&nbsp;&nbsp; 535&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; star=
t_cper_id =3D snapshot_rsp-&gt;start_cper_id;<br>
&nbsp;&nbsp;&nbsp; 536&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tota=
l_cper_num =3D snapshot_rsp-&gt;total_cper_num;<br>
&nbsp;&nbsp;&nbsp; 537 <br>
&nbsp;&nbsp;&nbsp; 538&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reco=
rd_req-&gt;buf_ptr =3D (uint64_t)(uintptr_t)buf;<br>
&nbsp;&nbsp;&nbsp; 539&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reco=
rd_req-&gt;buf_size =3D size;<br>
&nbsp;&nbsp;&nbsp; 540&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reco=
rd_req-&gt;cper_start_id =3D start_cper_id + *offset;<br>
&nbsp;&nbsp;&nbsp; 541&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reco=
rd_req-&gt;cper_num =3D total_cper_num;<br>
&nbsp;&nbsp;&nbsp; 542&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_ras_mgr_handle_ras_cmd(ring-&gt;adev, RAS_CMD__GET_CPER_RECORD,<=
br>
&nbsp;&nbsp;&nbsp; 543&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record_req, sizeof(struct=
 ras_cmd_cper_record_req),<br>
&nbsp;&nbsp;&nbsp; 544&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record_rsp, sizeof(struct=
 ras_cmd_cper_record_rsp));<br>
&nbsp;&nbsp;&nbsp; 545&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
r)<br>
&nbsp;&nbsp;&nbsp; 546&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp; 547 <br>
&nbsp;&nbsp;&nbsp; 548&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D *offset ? record_rsp-&gt;real_data_size : record_rsp-&gt;real_data_size=
 + ring_header_size;<br>
&nbsp;&nbsp;&nbsp; 549&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*of=
fset) +=3D record_rsp-&gt;real_cper_num;<br>
&nbsp;&nbsp;&nbsp; 550 <br>
&nbsp;&nbsp;&nbsp; 551&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn r;<br>
&nbsp;&nbsp;&nbsp; 552 }<br>
<br>
regards,<br>
dan carpenter<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB63454C81432E0C3BEE31648BFAD5ACY5PR12MB6345namp_--
